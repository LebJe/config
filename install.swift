// beak: onevcat/Rainbow @ 3.1.5
// beak: JohnSundell/Files @ 4.1.1
// beak: kareman/SwiftShell @ 5.0.1

import Rainbow
import Files
import SwiftShell

func ohMyZSH() {
	let ohMyZSH = try! Folder.current.subfolder(named: "oh-my-zsh")
}

func vim() {
	let vim = try! Folder.current.subfolder(named: "vim")
	
	let pluginsFile = try! vim.file(named: "plugins.txt")
	
	let pack = try! Folder.home.createSubfolderIfNeeded(withName: ".vim").createSubfolderIfNeeded(withName: "pack")
	
	for line in try! pluginsFile.readAsString().lines() {
		
	}
}

public func install() {
	ohMyZSH()
	vim()
	
	print("Success".green)
}
