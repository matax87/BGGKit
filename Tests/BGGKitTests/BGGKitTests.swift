import XCTest
@testable import BGGKit

final class BGGKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BGGKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
