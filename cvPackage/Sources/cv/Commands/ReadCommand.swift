// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import ArgumentParser
import Foundation

struct ReadCommand: ParsableCommand {
	static var configuration = CommandConfiguration(commandName: "read", abstract: "Reads configuration values.")

	@Argument(help: " The value of `key` should be one of: \(ConfigKey.allCases.map(\.rawValue).joined(separator: ", "))")
	var key: ConfigKey

	func run() {
		do {
			createDefaultConfig()

			let config = try readConfig()

			switch self.key {
				case .libLLDB: print("\(self.key.rawValue): \(config.libLLDB)")
			}

		} catch let error as DecodingError {
			fputs("Unable to decode the JSON configuration at `/.cv: \(error)", stderr)
		} catch {
			fputs("An error occurred: \(error.localizedDescription)", stderr)
		}
	}
}
