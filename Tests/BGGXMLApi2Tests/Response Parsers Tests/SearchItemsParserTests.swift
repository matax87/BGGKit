//
//  SearchItemsParserTests.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGXMLApi2
import XCTest

final class SearchItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParseWithInvalidXML", testParseWithInvalidXML),
        ("testParsePrimaryName", testParsePrimaryName),
        ("testParseWithAlternateName", testParseWithAlternateName)
    ]

    func testParseWithInvalidXML() throws {
        // Given
        let xmlData = Data.invalidXml()

        // When/Then
        XCTAssertThrowsError(try SearchItemsParser.parse(xmlData: xmlData))
    }

    func testParsePrimaryName() throws {
        // Given
        let xmlData = loadResource(withName: "searchItems1", extension: "xml")

        // When
        let parsedItems = try SearchItemsParser.parse(xmlData: xmlData)

        // Then
        XCTAssertEqual(parsedItems[0].id, "13")
        XCTAssertEqual(parsedItems[0].name, "Catan")
        XCTAssertEqual(parsedItems[0].type, .boardgame)
        XCTAssertNil(parsedItems[0].thumbnail)
        XCTAssertEqual(parsedItems[0].yearPublished, 1995)
    }

    func testParseWithAlternateName() throws {
        // Given
        let xmlData = loadResource(withName: "searchItems2", extension: "xml")

        // When
        let parsedItems = try SearchItemsParser.parse(xmlData: xmlData)

        // Then
        XCTAssertEqual(parsedItems[0].id, "823")
        XCTAssertEqual(parsedItems[0].name, "Il Signore Degli Anelli")
        XCTAssertEqual(parsedItems[0].type, .boardgame)
        XCTAssertNil(parsedItems[0].thumbnail)
        XCTAssertEqual(parsedItems[0].yearPublished, 2000)
        XCTAssertTrue(parsedItems[0].isAlternateName)
    }
}
