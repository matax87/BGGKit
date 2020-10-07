import XCTest

import BGGKitTests

var tests = [XCTestCaseEntry]()
tests += HotItemsParserTests.allTests()
tests += SearchItemsParserTests.allTests()
tests += ThingItemsParserTests.allTests()
tests += XMLApi2Tests.allTests()
tests += ThingPublisherTests.allTests()
tests += HotPublisherTests.allTests()
tests += SearchPublisherTests.allTests()
XCTMain(tests)
