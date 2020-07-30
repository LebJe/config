import Foundation
import SwiftShell

func getLinuxCPUTemp() {
	let strTemp = (try? String(contentsOf: URL(fileURLWithPath: "/sys/class/thermal/thermal_zone0/temp"))) ?? ""

	print((((Double(strTemp) ?? 0.0) / 1000.0) * 1.8) + 32)
}

func getCPUTemp() {
	#if os(macOS)
		print(run(Bundle.module.url(forResource: "osx-cpu-temp", withExtension: nil)!.path, "-F").stdout)
	#else
		getLinuxCPUTemp()
	#endif
}

getCPUTemp()
