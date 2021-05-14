//
//  File.swift
//  
//
//  Created by Jeff Lebrun on 5/12/21.
//

import ArgumentParser
import Foundation

struct SetCommand: ParsableCommand {
	static var configuration: CommandConfiguration = CommandConfiguration(commandName: "set", abstract: "Writess configuration values.")
	
	@Argument(help: " The value of `key` should be one of: \(ConfigKey.allCases.map(\.rawValue).joined(separator: ", "))")
	var key: ConfigKey

	@Argument(help: "The value you want to set `key` to.")
	var value: String

	func run() {
		createDefaultConfig()

		do {
			var config = try readConfig()

			switch key {
				case .libLLDB:
					config.libLLDB = value
			}

			try write(config: config)
		} catch let error as DecodingError {
			fputs("Unable to decode the JSON configuration at `/.cv: \(error)", stderr)
		} catch {
			fputs("An error occurred: \(error.localizedDescription)", stderr)
		}
	}
}
