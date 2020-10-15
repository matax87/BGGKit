//
//  HotItemsParserTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGKit
import XCTest

final class HotItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParsing", testParsing),
        ("testParsingWithOptionals", testParsingWithOptionals)
    ]

    func testParsing() {
        let xmlFileUrl = Bundle.module.url(forResource: "hotItems",
                                           withExtension: "xml")!
        let xmlData = try! Data(contentsOf: xmlFileUrl)
        let parser = HotItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Hot Items")
        parser.parse { result in
            do {
                let items = try result.get()
                XCTAssertNotNil(items.first)
                let item = items.first!
                XCTAssertEqual(item.id, "312484")
                XCTAssertEqual(item.name, "Lost Ruins of Arnak")
                XCTAssertEqual(item.rank, 1)
                XCTAssertEqual(item.thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/J8SVmGOJXZGxNjkT3xYNQU7Haxg=/fit-in/200x150/filters:strip_icc()/pic5674958.jpg")!)
                XCTAssertEqual(item.yearPublished, 2020)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testParsingWithOptionals() {
        let xmlFileUrl = Bundle.module.url(forResource: "hotItems",
                                           withExtension: "xml")!
        let xmlData = try! Data(contentsOf: xmlFileUrl)
        let parser = HotItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Hot Items")
        parser.parse { result in
            do {
                let items = try result.get()
                let item = items[15]
                XCTAssertEqual(item.id, "316554")
                XCTAssertEqual(item.name, "Dune: Imperium")
                XCTAssertEqual(item.rank, 16)
                expectation.fulfill()
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
