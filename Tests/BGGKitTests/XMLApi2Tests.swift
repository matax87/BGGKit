//
//  XMLApi2Tests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGKit
import XCTest

final class XMLApi2Tests: XCTestCase {
    static var allTests = [
        ("testHot", testHot),
        ("testSearch", testSearch),
    ]

    func testHot() {
        let xmlApi2 = XMLApi2()
        let expectation = XCTestExpectation(description: "BGG Hot")
        xmlApi2.hot { result in
            do {
                let items = try result.get()
                XCTAssertFalse(items.isEmpty)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testSearch() {
        let xmlApi2 = XMLApi2()
        let expectation = XCTestExpectation(description: "BGG Search")
        xmlApi2.search(query: "catan", matchExactly: true) { result in
            do {
                let items = try result.get()
                XCTAssertFalse(items.isEmpty)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testThing() {
        let xmlApi2 = XMLApi2()
        let expectation = XCTestExpectation(description: "BGG Thing")
        let ids = ["1", "2"]
        xmlApi2.thing(ids: ids) { result in
            do {
                let items = try result.get()
                XCTAssertTrue(items.count == ids.count)
                XCTAssertEqual(items[0].id, ids[0])
                XCTAssertEqual(items[1].id, ids[1])
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
