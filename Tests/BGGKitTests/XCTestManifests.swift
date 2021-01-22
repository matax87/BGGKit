import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        return [
            testCase(ThingItemsParserTests.allTests),
            testCase(ThingPublisherTests.allTests),

            testCase(FamilyItemsParserTests.allTests),
            testCase(FamilyPublisherTests.allTests),

            testCase(HotItemsParserTests.allTests),
            testCase(HotPublisherTests.allTests),

            testCase(SearchItemsParserTests.allTests),
            testCase(SearchPublisherTests.allTests),

            testCase(XMLApi2Tests.allTests)
        ]
    }
#endif
