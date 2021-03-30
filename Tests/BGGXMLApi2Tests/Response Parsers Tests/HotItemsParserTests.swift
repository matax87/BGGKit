//
//  HotItemsParserTests.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGXMLApi2
import XCTest

final class HotItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParseWithInvalidXML", testParseWithInvalidXML),
        ("testParse", testParse),
        ("testParseWithOptionals", testParseWithOptionals),
    ]

    func testParseWithInvalidXML() throws {
        // Given
        let xmlData = Data.invalidXml()

        // When/Then
        XCTAssertThrowsError(try HotItemsParser.parse(xmlData: xmlData))
    }

    func testParse() throws {
        // Given
        let xmlData = loadResource(withName: "hotItems", extension: "xml")

        // When
        let parsedItems = try HotItemsParser.parse(xmlData: xmlData)

        // Then
        XCTAssertEqual(parsedItems[0].id, "312484")
        XCTAssertEqual(parsedItems[0].name, "Lost Ruins of Arnak")
        XCTAssertEqual(parsedItems[0].rank, 1)
        XCTAssertEqual(parsedItems[0].thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/J8SVmGOJXZGxNjkT3xYNQU7Haxg=/fit-in/200x150/filters:strip_icc()/pic5674958.jpg")!)
        XCTAssertEqual(parsedItems[0].yearPublished, 2020)
    }

    func testParseWithOptionals() throws {
        // Given
        let xmlData = loadResource(withName: "hotItems", extension: "xml")

        // When
        let parsedItems = try HotItemsParser.parse(xmlData: xmlData)

        // Then
        XCTAssertEqual(parsedItems[15].id, "316554")
        XCTAssertEqual(parsedItems[15].name, "Dune: Imperium")
        XCTAssertEqual(parsedItems[15].rank, 16)
    }
}
