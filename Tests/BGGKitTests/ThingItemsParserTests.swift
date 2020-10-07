//
//  ThingItemsParserTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import XCTest
@testable import BGGKit

final class ThingItemsParserTests: XCTestCase {

    static var allTests = [
        ("testParsing", testParsing)
    ]

    func testParsing() {
        let xmlData = ThingItems.xmlString.data(using: .utf8)!
        let parser = ThingItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Thing Items")
        parser.parse { result in
            do {
                let items = try result.get()
                XCTAssertNotNil(items.first)
                let item = items.first!
                XCTAssertEqual(item.id, "13")
                XCTAssertEqual(item.name, "Catan")
                XCTAssertEqual(item.type, .boardgame)
                XCTAssertEqual(item.thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/8a9HeqFydO7Uun_le9bXWPnidcA=/fit-in/200x150/filters:strip_icc()/pic2419375.jpg")!)
                XCTAssertEqual(item.image, URL(string: "https://cf.geekdo-images.com/original/img/A-0yDJkve0avEicYQ4HoNO-HkK8=/0x0/pic2419375.jpg")!)
                XCTAssertFalse(item.description.isEmpty)
                XCTAssertEqual(item.yearPublished, 1995)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}

