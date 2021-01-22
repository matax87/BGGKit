import XCTest

import BGGKitTests

var tests = [XCTestCaseEntry]()
tests += ThingItemsParserTests.allTests()
tests += FamilyItemsParserTests.allTests()
tests += HotItemsParserTests.allTests()
tests += SearchItemsParserTests.allTests()
tests += XMLApi2Tests.allTests()
tests += ThingPublisherTests.allTests()
tests += HotPublisherTests.allTests()
tests += SearchPublisherTests.allTests()
XCTMain(tests)
