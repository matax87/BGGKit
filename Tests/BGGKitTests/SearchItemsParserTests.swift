//
//  SearchItemsParserTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGKit
import XCTest

final class SearchItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParsingPrimaryName", testParsingPrimaryName),
        ("testParsingWithAlternateName", testParsingWithAlternateName)
    ]

    func testParsingPrimaryName() {
        let xmlFileUrl = Bundle.module.url(forResource: "searchItems1",
                                           withExtension: "xml")!
        let xmlData = try! Data(contentsOf: xmlFileUrl)
        let parser = SearchItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Search Items")
        parser.parse { result in
            do {
                let items = try result.get()
                XCTAssertNotNil(items.first)
                let item = items.first!
                XCTAssertEqual(item.id, "13")
                XCTAssertEqual(item.name, "Catan")
                XCTAssertEqual(item.type, .boardgame)
                XCTAssertNil(item.thumbnail)
                XCTAssertEqual(item.yearPublished, 1995)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testParsingWithAlternateName() {
        let xmlFileUrl = Bundle.module.url(forResource: "searchItems2",
                                           withExtension: "xml")!
        let xmlData = try! Data(contentsOf: xmlFileUrl)
        let parser = SearchItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Search Items")
        parser.parse { result in
            do {
                let items = try result.get()
                XCTAssertNotNil(items.first)
                let item = items.first!
                XCTAssertEqual(item.id, "823")
                XCTAssertEqual(item.name, "Il Signore Degli Anelli")
                XCTAssertEqual(item.type, .boardgame)
                XCTAssertNil(item.thumbnail)
                XCTAssertEqual(item.yearPublished, 2000)
                XCTAssertTrue(item.isAlternateName)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
