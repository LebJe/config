import Foundation
import SwiftShell

func getLinuxCPUTemp() {
	let strTemp = (try? String(contentsOf: URL(fileURLWithPath: "/sys/class/thermal/thermal_zone0/temp"))) ?? ""

	let celTemp = Double((Int(strTemp.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0)) / 1000.0 

	let fTemp = celTemp * (9 / 5) + 32

	print(String(format: "%.2f °F", fTemp))
}

func getCPUTemp() {
	#if os(macOS)
		print(run(Bundle.module.url(forResource: "osx-cpu-temp", withExtension: nil)!.path, "-F").stdout)
	#else
		getLinuxCPUTemp()
	#endif
}

getCPUTemp()
