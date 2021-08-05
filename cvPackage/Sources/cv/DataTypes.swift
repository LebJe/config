// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import Foundation

enum ModuleType: String, Codable {
	case clangTarget = "ClangTarget"
	case swiftTarget = "SwiftTarget"
}

enum TargetType: String, Codable {
	case executable, library, test
}

struct Target: Codable {
	let c99name: String
	let moduleType: String
	let name: String
	let path: String
	let sources: [String]
	let type: TargetType

	enum CodingKeys: String, CodingKey {
		case c99name,
		     moduleType = "module_type",
		     name,
		     path,
		     sources,
		     type
	}
}

struct PackageDescription: Codable {
	let name: String
	let path: String
	let targets: [Target]
}

struct ConfigurationInner: Codable {
	let request: String
	let program: String
	var args: [String] = []
}

struct ConfigurationOuter: Codable {
	let adapter: String
	var `default`: Bool = false
	var breakpoints: [String: [String: String]] = [:]
	let configuration: ConfigurationInner
}

struct VimspectorConfig: Codable {
	var schema = URL(string: "https://puremourning.github.io/vimspector/schema/vimspector.schema.json")!
	let configurations: [String: ConfigurationOuter]

	private enum CodingKeys: String, CodingKey {
		case schema = "$schema"
		case configurations
	}
}

struct Config: Codable {
	var libLLDB: String
}

let defaultBreakpoints = ["exception": ["cpp_throw": "Y", "cpp_catch": "Y"]]
var defaultLibLLDB: String {
	#if os(macOS)
		"/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"
	#elseif os(Linux)
		"/usr/lib/liblldb.so"
	#endif
}

let defaultAdapterSwift = "CodeLLDB-Swift"
let defaultAdapterC = "CodeLLDB"
