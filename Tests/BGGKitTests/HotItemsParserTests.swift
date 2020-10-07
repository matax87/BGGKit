//
//  HotItemsParserTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import XCTest
@testable import BGGKit

final class HotItemsParserTests: XCTestCase {

    static var allTests = [
        ("testParsing", testParsing),
        ("testParsingWithOptionals", testParsingWithOptionals)
    ]

    func testParsing() {
        let xmlData = HotItems.xmlString1.data(using: .utf8)!
        let parser = HotItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Hot Items")
        parser.parse { result in
            do {
                let items = try result.get()
                XCTAssertNotNil(items.first)
                let item = items.first!
                XCTAssertEqual(item.id, "304420")
                XCTAssertEqual(item.name, "Bonfire")
                XCTAssertEqual(item.rank, 1)
                XCTAssertEqual(item.thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/Vi9tZ60juVkTpNoUIdLFzW8N9Aw=/fit-in/200x150/filters:strip_icc()/pic5301335.jpg")!)
                XCTAssertEqual(item.yearPublished, 2020)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testParsingWithOptionals() {
        let xmlData = HotItems.xmlString2.data(using: .utf8)!
        let parser = HotItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Hot Items")
        parser.parse { result in
            do {
                let items = try result.get()
                XCTAssertNotNil(items.first)
                let item = items.first!
                XCTAssertEqual(item.id, "316554")
                XCTAssertEqual(item.name, "Dune: Imperium")
                XCTAssertEqual(item.rank, 3)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}

