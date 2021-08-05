// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import ArgumentParser

struct ConfigCommand: ParsableCommand {
	static var configuration = CommandConfiguration(
		commandName: "config",
		abstract: "Manages cv configuration.",
		subcommands: [SetCommand.self, ReadCommand.self]
	)
}
