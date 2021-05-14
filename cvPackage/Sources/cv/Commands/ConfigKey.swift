//
//  File.swift
//  
//
//  Created by Jeff Lebrun on 5/12/21.
//

import ArgumentParser

enum ConfigKey: String, CaseIterable, ExpressibleByArgument {
	case libLLDB = "lib-lldb"
}
