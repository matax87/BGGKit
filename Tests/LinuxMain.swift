import XCTest

import BGGKitTests

var tests = [XCTestCaseEntry]()
tests += ThingItemsParserTests.allTests()
tests += ThingPublisherTests.allTests()

tests += FamilyItemsParserTests.allTests()
tests += FamilyPublisherTests.allTests()

tests += HotItemsParserTests.allTests()
tests += HotPublisherTests.allTests()

tests += SearchItemsParserTests.allTests()
tests += SearchPublisherTests.allTests()

tests += XMLApi2Tests.allTests()

XCTMain(tests)
