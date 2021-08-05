// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import ArgumentParser
import Foundation

struct SetCommand: ParsableCommand {
	static var configuration = CommandConfiguration(commandName: "set", abstract: "Writess configuration values.")

	@Argument(help: " The value of `key` should be one of: \(ConfigKey.allCases.map(\.rawValue).joined(separator: ", "))")
	var key: ConfigKey

	@Argument(help: "The value you want to set `key` to.")
	var value: String

	func run() {
		createDefaultConfig()

		do {
			var config = try readConfig()

			switch self.key {
				case .libLLDB:
					config.libLLDB = self.value
			}

			try write(config: config)
		} catch let error as DecodingError {
			fputs("Unable to decode the JSON configuration at `/.cv: \(error)", stderr)
		} catch {
			fputs("An error occurred: \(error.localizedDescription)", stderr)
		}
	}
}
