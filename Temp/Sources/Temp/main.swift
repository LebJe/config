import Foundation
import SwiftShell

func getLinuxCPUTemp() {
	#if os(Linux)
	#endif
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
