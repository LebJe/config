#!/usr/bin/env swift

import Foundation

/// Replaces the icon at `<appResourceFolder>/<iconName>` with the icon at `iconFileURL`.
func replaceIcon(at appResourceFolder: URL, with iconFileURL: URL, oldIconName: String? = nil) throws {
	let oldIconName = oldIconName == nil ? try FileManager
			.default
			.contentsOfDirectory(atPath: appResourceFolder.path)
			.filter({ $0.contains(".icns") })[0]
			.replacingOccurrences(of: ".icns", with: "") : oldIconName!

	let appIconData = try Data(contentsOf: iconFileURL)

	try appIconData.write(to: appResourceFolder.appendingPathComponent(oldIconName + ".icns"))
}

struct Icon {
	let appResourcesPath: URL
	let iconPath: URL
	let oldIconName: String?

	init(appResourcesPath: URL, iconPath: URL, oldIconName: String? = nil) {
		self.appResourcesPath = appResourcesPath
		self.iconPath = iconPath
		self.oldIconName = oldIconName
	}
}

let icons = [
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/Docker.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/2171818b5f62a0454953edaec89b1c27_Docker.icns")
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/Roblox.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/c4b360e85e3cc50b0f085e5fd738e281_Roblox_Alt_2.icns")
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/RobloxStudio.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/429dd9cf4acd5945eacd0ea5f5f90a0c_RobloxStudio_Alt.icns")
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/Visual Studio Code.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/f03f0fa23eb9ccfaa63ade898b763b54_Microsoft_Visual_Studio_Code_Alt_2.icns"),
		oldIconName: "Code"
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/Wireshark.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/817bd2667adeb856fbb2d24957dcdcbc_1605425541008_Wireshark.icns"),
		oldIconName: "Wireshark"
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications//Turbo Boost Switcher Pro.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/1f8eeb2a5f6069a0b53d1adb451df686_Turbo_Boost_Switcher_Pro.icns")
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/AdvancedRestClient.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/004452e5ddcaf45a09017276ceb73d13_1606498062011_Advanced_Rest_Client.icns")
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/Visual Studio Code - Insiders.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/84350af0b1becad4fe974c8f5f66d197_1606763360883_Visual Studio Code Insiders.icns"),
		oldIconName: "Code - Insiders"
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/Raycast.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/13f60983d18415b0dc0a4444d19d3001_1605527742660_raycast.icns")
	),
	Icon(
		appResourcesPath: URL(fileURLWithPath: "/Applications/Firefox.app/Contents/Resources"),
		iconPath: URL(fileURLWithPath: "~/config/Icons/8d0343f61ae1c3103bb2d656bcfde463_Firefox.icns")
	)
]

for icon in icons {
	do {
		try replaceIcon(at: icon.appResourcesPath, with: icon.iconPath, oldIconName: icon.oldIconName)
	} catch {
		print("An error occured: \(error.localizedDescription)")
	}
}