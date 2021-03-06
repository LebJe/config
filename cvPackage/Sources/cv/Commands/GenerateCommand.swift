import ArgumentParser
import Foundation
import ShellOut

enum Type: String, CaseIterable, ExpressibleByArgument {
	init?(argument: String) {
		switch argument {
			case "c": self = .c
			case "swift": self = .swift
			default: return nil
		}
	}

	case c, swift
}

struct GenerateCommand: ParsableCommand {
	static var configuration: CommandConfiguration = CommandConfiguration(commandName: "generate", abstract: "Generates configuration files for Vimspector.")

	@Option(name: [.long, .short], help: "Where you want the generated .vimspector.json to go. Use \"-\" to send it to standard output.")
	var output: String = ".vimspector.json"

	@Option(name: [.long], parsing: .remaining, help: "The arguments to pass to the executable.")
	var args: [String] = []

	@Argument(
		help: "The type of configuration file you would like to generate. You can generate C/C++ config files, or Swift config files. The value of `type` should be one of: \(Type.allCases.map(\.rawValue).joined(separator: ", "))"
	)
	var type: Type

	@Argument(help: "The path of the C/C++ executable you would like Vimspector to run.", completion: .file())
	var cExecutablePath: String?

	func run() throws {
		switch type {
			case .c:
				if let path = cExecutablePath {
					generateCConfig(path: path)
				} else {
					fputs("Please provide a value for `c-executable-path`.", stderr)
					Foundation.exit(1)
				}
			case .swift:
				generateSwiftConfig()
		}
	}

	func generateCConfig(path: String) {
		let vConfig = VimspectorConfig(
			schema: URL(string: "https://puremourning.github.io/vimspector/schema/vimspector.schema.json#")!,
			configurations: [
				"\(path) - Run": ConfigurationOuter(
					adapter: defaultAdapterC,
					variables: [:],
					default: true,
					breakpoints: defaultBreakpoints,
					configuration: ConfigurationInner(
						request: "launch",
						program: "\(path)",
						args: args
					)
				)
			]
		)

		let encoder = JSONEncoder()
		encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]

		if output == "-" {
			print(String(data: try! encoder.encode(vConfig), encoding: .utf8)!)
		} else {
			try! encoder.encode(vConfig).write(to: URL(fileURLWithPath: output))
		}
	}

	func generateSwiftConfig() {
		let schema = URL(string: "https://puremourning.github.io/vimspector/schema/vimspector.schema.json#")!
		var res: String = ""
		do {
			res = try shellOut(to: "swift", arguments: ["package", "describe", "--type", "json"])
			let packageD = try JSONDecoder().decode(PackageDescription.self, from: res.data(using: .utf8)!)

			var configs: [String: ConfigurationOuter] = [:]

			var alreadyParsedTest = false

			for t in packageD.targets {
				switch t.type {
					case .library: break
					case .executable:
						configs["Target \(t.name) - Run Executable"] = .init(
							adapter: defaultAdapterSwift,
							variables: try defaultVariables(),
							default: true,
							breakpoints: defaultBreakpoints,
							configuration: .init(
								request: "launch",
								program: "${workspaceRoot}/.build/debug/\(t.name)",
								args: args
							)
						)
					case .test:
						if !alreadyParsedTest {
							alreadyParsedTest = true
							configs["Run Tests"] = .init(
								adapter: defaultAdapterSwift,
								variables: try defaultVariables(),
								default: false,
								breakpoints: defaultBreakpoints,
								configuration: .init(
									request: "launch",
									program: "${workspaceRoot}/.build/debug/\(packageD.name + "PackageTests").xcTest\(xcTestIsExecutable() ? "" : "/Contents/MacOS/\(packageD.name + "PackageTests")")",
									args: args
								)
							)
						}
				}
			}

			let vConfig = VimspectorConfig(
				schema: schema,
				configurations: configs
			)

			let encoder = JSONEncoder()
			encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]

			if output == "-" {
				print(String(data: try encoder.encode(vConfig), encoding: .utf8)!)
			} else {
				try encoder.encode(vConfig).write(to: URL(fileURLWithPath: output))
			}
		} catch is ShellOutError {
			fputs("Unable to execute \"swift\" with arguments \"package describe --type json\".", stderr)
		} catch is DecodingError {
			fputs("Unable to decode the output of \"swift package describe --type json\": \nOutput:\n\(res)", stderr)
		} catch {
			fputs("An error occurred: \(error.localizedDescription)", stderr)
		}
	}

	func xcTestIsExecutable() -> Bool {
		#if os(macOS)
			false
		#else
			true
		#endif
	}
}
