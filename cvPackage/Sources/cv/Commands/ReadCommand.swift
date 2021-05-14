//
//  File.swift
//  
//
//  Created by Jeff Lebrun on 5/12/21.
//

import ArgumentParser
import Foundation

struct ReadCommand: ParsableCommand {
	static var configuration: CommandConfiguration = CommandConfiguration(commandName: "read", abstract: "Reads configuration values.")

	@Argument(help: " The value of `key` should be one of: \(ConfigKey.allCases.map(\.rawValue).joined(separator: ", "))")
	var key: ConfigKey

	func run() {
		do {
			createDefaultConfig()

			let config = try readConfig()

			switch key {
				case .libLLDB: print("\(key.rawValue): \(config.libLLDB)")
			}

		} catch let error as DecodingError {
			fputs("Unable to decode the JSON configuration at `/.cv: \(error)", stderr)
		} catch {
			fputs("An error occurred: \(error.localizedDescription)", stderr)
		}
	}
}
