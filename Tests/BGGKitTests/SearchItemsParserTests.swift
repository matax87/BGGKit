//
//  SearchItemsParserTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import XCTest
@testable import BGGKit

final class SearchItemsParserTests: XCTestCase {

    static var allTests = [
        ("testParsingPrimaryName", testParsingPrimaryName),
        ("testParsingWithAlternateName", testParsingWithAlternateName)
    ]

    func testParsingPrimaryName() {
        let xmlData = SearchItems.xmlString1.data(using: .utf8)!
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
                XCTAssertEqual(item.yearPublished, "1995")
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testParsingWithAlternateName() {
        let xmlData = SearchItems.xmlString2.data(using: .utf8)!
        let parser = SearchItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Search Items")
        parser.parse { result in
            do {
                let items = try result.get()
                XCTAssertNotNil(items.first)
                let item = items.first!
                XCTAssertEqual(item.id, "316630")
                XCTAssertEqual(item.name, "Il Signore degli Anelli: Viaggi nella Terra di Mezzo – Creature dell’Oscurità")
                XCTAssertEqual(item.type, .boardgame)
                XCTAssertNil(item.thumbnail)
                XCTAssertEqual(item.yearPublished, "2020")
                XCTAssertTrue(item.isAlternateName)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}

