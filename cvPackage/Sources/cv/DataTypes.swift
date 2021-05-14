import Foundation

enum ModuleType: String, Codable {
	case clangTarget = "ClangTarget"
	case swiftTarget = "SwiftTarget"
}

enum TargetType: String, Codable {
	case executable, library, test
}

struct Target: Codable {
	let c99name: String
	let moduleType: String
	let name: String
	let path: String
	let sources: [String]
	let type: TargetType

	enum CodingKeys: String, CodingKey {
		case c99name,
			 moduleType = "module_type",
			 name,
			 path,
			 sources,
			 type
	}
}

struct PackageDescription: Codable {
	let name: String
	let path: String
	let targets: [Target]
}

struct ConfigurationInner: Codable {
	let request: String
	let program: String
	var args: [String] = []
}

struct ConfigurationOuter: Codable {
	let adapter: String
	let variables: [String: String]
	let `default`: Bool
	var breakpoints: [String: [String: String]] = [:]
	let configuration: ConfigurationInner
}

struct VimspectorConfig: Codable {
	let schema: URL
	let configurations: [String: ConfigurationOuter]

	private enum CodingKeys: String, CodingKey {
		case schema = "$schema"
		case configurations
	}
}

struct Config: Codable {
	var libLLDB: String
}

let defaultBreakpoints = ["exception": ["cpp_throw": "Y", "cpp_catch": "Y"]]
var defaultLibLLDB: String {
	#if os(macOS)
	"/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"
	#elseif os(Linux)
	"/usr/lib/liblldb.so"
	#endif
}

let defaultAdapterSwift = "CodeLLDB-Swift"
let defaultAdapterC = "CodeLLDB"

func defaultVariables() throws -> [String: String] {
	createDefaultConfig()
	let c = try readConfig()
	let defaultVariables = ["LibLLDB": "\(c.libLLDB)"]
	return defaultVariables
}
