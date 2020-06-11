import XCTest

import cleanBackupsTests

var tests = [XCTestCaseEntry]()
tests += cleanBackupsTests.allTests()
XCTMain(tests)
