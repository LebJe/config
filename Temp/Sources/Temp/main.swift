import Foundation
import SwiftShell

func getLinuxCPUTemp() {
	let strTemp = (try? String(contentsOf: URL(fileURLWithPath: "/sys/class/thermal/thermal_zone0/temp"))) ?? ""

	let temp = (((Double(strTemp) ?? 0.0) / 1000.0) * 1.8) + 32

	print(temp)
}

func getCPUTemp() {
	#if os(macOS)
		let url = Bundle.module.url(forResource: "osx-cpu-temp", withExtension: nil)!.path
		let res = run(url, "-F")
		print(res.stdout)
	#else
		getLinuxCPUTemp()
	#endif
}

getCPUTemp()
