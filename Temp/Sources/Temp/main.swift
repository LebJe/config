import Foundation
import SwiftShell

func getLinuxCPUTemp() {
	let strTemp = try! String(contentsOf: URL(fileURLWithPath: "/sys/class/thermal/thermal_zone0/temp"))

	print("StrTemp: \(strTemp)")

	let celTemp = Double(Double(Int(strTemp) ?? 0) / 1000.0)

	print("CelTemp: \(celTemp)")

	let fTemp = celTemp * (9 / 5) + 32

	print(fTemp)
}

func getCPUTemp() {
	#if os(macOS)
		print(run(Bundle.module.url(forResource: "osx-cpu-temp", withExtension: nil)!.path, "-F").stdout)
	#else
		getLinuxCPUTemp()
	#endif
}

getCPUTemp()
