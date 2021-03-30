import XCTest

import BGGXMLApi2Tests
import StackParsingTests

var tests = [XCTestCaseEntry]()
tests += ThingItemsParserTests.allTests()
tests += ThingPublisherTests.allTests()

tests += FamilyItemsParserTests.allTests()
tests += FamilyPublisherTests.allTests()

tests += HotItemsParserTests.allTests()
tests += HotPublisherTests.allTests()

tests += SearchItemsParserTests.allTests()
tests += SearchPublisherTests.allTests()

tests += clientTests.allTests()

tests += Tests.allTests()

XCTMain(tests)
