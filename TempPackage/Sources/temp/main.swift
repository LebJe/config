import Foundation
import ArgumentParser
#if canImport(OSXCPUTemp)
import OSXCPUTemp
#endif

enum TempFormat: String, CaseIterable, ExpressibleByArgument {
	case celsius, fahrenheit
}

extension Double {
	var fahrenheit: Self { self * (9 / 5) + 32 }
}

struct TempCommand: ParsableCommand {

	static let configuration = CommandConfiguration(
		commandName: "temp",
		abstract: "Calculates CPU temperature on Mac and Linux.",
		version: "1.0.0"
	)

	@Option(name: [.long, .short], help: "Whether to display the temperature in Celsius or Fahrenheit")
	var format: TempFormat = .fahrenheit

	func getLinuxCPUTemp(tempFormat: TempFormat = .fahrenheit) {
		guard let strTemp = (try? String(contentsOf: URL(fileURLWithPath: "/sys/class/thermal/thermal_zone0/temp"))) else {
			fputs("/sys/class/thermal/thermal_zone0/temp not found!\n", stderr)
			Foundation.exit(1)
		}

		let temp = Double((Int(strTemp.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0)) / 1000.0

		print(String(format: "%.2f °\(format == .fahrenheit ? "F" : "C")", tempFormat == .fahrenheit ? temp.fahrenheit : temp))
	}

	func getCPUTemp() {
		#if os(macOS)
			SMCOpen()

			let temp = SMC_KEY_CPU_TEMP.withCString({ SMCGetTemperature(UnsafeMutablePointer(mutating: $0)) })
			print(String(format: "%.2f °\(format == .fahrenheit ? "F" : "C")", format == .fahrenheit ? temp.fahrenheit : temp))

			SMCClose()
		#else
			getLinuxCPUTemp()
		#endif
	}

	func run() throws {
		getCPUTemp()
	}
}

TempCommand.main()
