// beak: onevcat/Rainbow @ 3.1.5
// beak: JohnSundell/Files @ 4.1.1
// beak: kareman/SwiftShell @ 5.0.1

import Rainbow
import Files
import SwiftShell
import Foundation

func ohMyZSH() {
	guard let ohMyZSHFolder = try? Folder.current.subfolder(named: "oh-my-zsh") else {
		print("Not in config directory.")
		Foundation.exit(1)
	}
	
	let home = ProcessInfo.processInfo.environment["HOME"]!
	
	let pluginsFile = try! ohMyZSHFolder.file(named: "plugins.txt").readAsString()
	let themesFile = try! ohMyZSHFolder.file(named: "themes.txt").readAsString()
	
	for line in pluginsFile.lines() {
		let formattedURL = URL(string: line)!.lastPathComponent.replacingOccurrences(of: ".git", with: "")
		
		print(run("git", "clone", "--depth=1", line, "\(home)/.oh-my-zsh/custom/plugins/\(formattedURL)").stderror)
	}
	
	for line in themesFile.lines() {
		let formattedURL = URL(string: line)!.lastPathComponent.replacingOccurrences(of: ".git", with: "")
		
		print(run("git", "clone", "--depth=1", line, "\(home)/.oh-my-zsh/custom/themes/\(formattedURL)").stderror)
	}

}

public func install() {
	ohMyZSH()
	
	print("Success".green)
}
