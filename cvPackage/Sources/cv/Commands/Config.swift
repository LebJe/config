// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import Foundation

let configFileName = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".cv").path

func createDefaultConfig() {
	if !FileManager.default.fileExists(atPath: configFileName) {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]

		try? encoder.encode(Config(libLLDB: defaultLibLLDB)).write(to: URL(fileURLWithPath: configFileName))
	}
}

func readConfig() throws -> Config {
	try JSONDecoder().decode(Config.self, from: FileManager.default.contents(atPath: configFileName)!)
}

func write(config: Config) throws {
	let encoder = JSONEncoder()
	encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]

	try encoder.encode(config).write(to: URL(fileURLWithPath: configFileName))
}
