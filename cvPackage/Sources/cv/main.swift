// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import ArgumentParser

struct Main: ParsableCommand {
	static var configuration = CommandConfiguration(
		commandName: "cv",
		abstract: "Generates configuration files for Vimspector.",
		version: "0.0.1",
		subcommands: [ConfigCommand.self, GenerateCommand.self],
		defaultSubcommand: GenerateCommand.self
	)
}

Main.main()
