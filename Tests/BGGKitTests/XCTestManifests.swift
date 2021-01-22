import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        return [
            testCase(ThingItemsParserTests.allTests),
            testCase(FamilyItemsParserTests.allTests),
            testCase(HotItemsParserTests.allTests),
            testCase(SearchItemsParserTests.allTests),
            testCase(XMLApi2Tests.allTests),
            testCase(ThingPublisherTests.allTests),
            testCase(HotPublisherTests.allTests),
            testCase(SearchPublisherTests.allTests)
        ]
    }
#endif
