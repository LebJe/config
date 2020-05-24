// beak: onevcat/Rainbow @ 3.1.5
// beak: JohnSundell/Files @ 4.1.1
// beak: kareman/SwiftShell @ 5.0.1

import Rainbow
import Files
import SwiftShell
import Foundation

let home = ProcessInfo.processInfo.environment["HOME"]!

func ohMyZSH() {
	guard let ohMyZSHFolder = try? Folder.current.subfolder(named: "oh-my-zsh") else {
		print("Not in config directory.")
		Foundation.exit(1)
	}
	
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

func vim() {
    run("vim", "+PluginInstall", "+qall")
}

public func install() {
	ohMyZSH()
    vim()
	
	print(run("ln", ".vimrc", home).stdout)
	print(run("ln", ".zshrc", home).stdout)
	
	print("Success".green)
}
