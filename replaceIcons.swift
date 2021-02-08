import Foundation

if CommandLine.arguments.dropFirst().count < 2 {
	print("USAGE: \(CommandLine.arguments[0]) path/to/app path/to/icon")
	exit(1)
}

let args = CommandLine.arguments
let appFolder = args[1]
let iconFile = args[2]

let appFolderURL = URL(fileURLWithPath: appFolder)
	.appendingPathComponent("Contents")
	.appendingPathComponent("Resources")

let iconFileURL = URL(fileURLWithPath: iconFile)

var oldIconName: String = ""

if appFolder.contains("Visual Studio Code - Insiders") {
	oldIconName = "Code - Insiders"
} else if appFolder.contains("Visual Studio Code") {
	oldIconName = "Code"
} else {
	oldIconName = try FileManager
		.default
		.contentsOfDirectory(atPath: appFolderURL.path)
		.filter({ $0.contains(".icns") })[0]
		.replacingOccurrences(of: ".icns", with: "")
}

let appIconData = try Data(contentsOf: iconFileURL)

try appIconData.write(to: appFolderURL.appendingPathComponent(oldIconName + ".icns"))
