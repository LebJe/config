//
//  File.swift
//  
//
//  Created by Jeff Lebrun on 5/12/21.
//

import ArgumentParser

struct ConfigCommand: ParsableCommand {
	static var configuration: CommandConfiguration = CommandConfiguration(
		commandName: "config",
		abstract: "Manages cv configuration.",
		subcommands: [SetCommand.self, ReadCommand.self]
	)
}
