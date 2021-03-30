//
//  ClientTests.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGXMLApi2
import XCTest

final class ClientTests: XCTestCase {
    var client: Client!

    static var allTests = [
        ("testThing", testThing),
        ("testHot", testHot),
        ("testFamily", testHot),
        ("testSearch", testSearch)
    ]

    override func setUpWithError() throws {
        client = Client()
    }

    func testThing() throws {
        // Given
        let expectation = self.expectation(description: "\(#function)")
        let ids = ["1", "2"]
        var result: Result<[ThingItem], Error>?

        // When
        client.thing(ids: ids) {
            result = $0
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 3.0)
        let items = try XCTUnwrap(result?.get())
        XCTAssertEqual(items.map(\.id), ids)
    }

    func testFamily() throws {
        // Given
        let ids = ["1", "2"]
        var result: Result<[FamilyItem], Error>?
        let expectation = self.expectation(description: "\(#function)")

        // When
        client.family(ids: ids) {
            result = $0
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 3.0)
        let items = try XCTUnwrap(result?.get())
        XCTAssertEqual(items.map(\.id), ids)
    }

    func testHot() throws {
        // Given
        var result: Result<[HotItem], Error>?
        let expectation = self.expectation(description: "\(#function)")

        // When
        client.hot {
            result = $0
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 3.0)
        let items = try XCTUnwrap(result?.get())
        XCTAssertFalse(items.isEmpty)
    }

    func testSearch() throws {
        // Given
        let searchText = "catan"
        var result: Result<[SearchItem], Error>?
        let expectation = self.expectation(description: "\(#function)")

        // When
        client.search(
            query: searchText,
            matchExactly: true
        ) {
            result = $0
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 3.0)
        let items = try XCTUnwrap(result?.get())
        XCTAssertFalse(items.isEmpty)
    }
}
