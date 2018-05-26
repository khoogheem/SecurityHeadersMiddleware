import XCTest

import securityHeadersMiddlewareTests

var tests = [XCTestCaseEntry]()
tests += securityHeadersMiddlewareTests.allTests()
XCTMain(tests)