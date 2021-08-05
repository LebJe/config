// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import ArgumentParser

enum ConfigKey: String, CaseIterable, ExpressibleByArgument {
	case libLLDB = "lib-lldb"
}
