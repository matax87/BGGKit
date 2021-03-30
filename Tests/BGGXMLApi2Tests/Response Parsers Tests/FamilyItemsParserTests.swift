//
//  FamilyItemsParserTests.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 22/01/2021.
//

@testable import BGGXMLApi2
import XCTest

final class FamilyItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParseWithInvalidXML", testParseWithInvalidXML),
        ("testParse", testParse)
    ]

    func testParseWithInvalidXML() throws {
        // Given
        let xmlData = Data.invalidXml()

        // When/Then
        XCTAssertThrowsError(try FamilyItemsParser.parse(xmlData: xmlData))
    }

    func testParse() throws {
        // Given
        let xmlData = loadResource(withName: "familyItems", extension: "xml")

        // When
        let parsedItems = try FamilyItemsParser.parse(xmlData: xmlData)

        // Then
        XCTAssertEqual(parsedItems.count, 2)

        XCTAssertEqual(parsedItems[0].id, "1")
        XCTAssertEqual(parsedItems[0].name, "Test Family")
        XCTAssertEqual(parsedItems[0].names, [
            Name(kind: .primary, value: "Test Family"),
            Name(kind: .alternate, value: "Another Test Family"),
        ])
        XCTAssertEqual(parsedItems[0].type, .boardgameFamily)
        XCTAssertEqual(parsedItems[0].thumbnail, URL(string: "https://cf.geekdo-images.com/AKJnFj40lhCRU-T5WpQigw__thumb/img/8Td1xqSG6RqZ6PoijvQL0q5sCWY=/fit-in/200x150/filters:strip_icc()/pic1246781.jpg")!)
        XCTAssertEqual(parsedItems[0].image, URL(string: "https://cf.geekdo-images.com/AKJnFj40lhCRU-T5WpQigw__original/img/2p1Kn54uXswvhkuoAzLDruE4J_4=/0x0/filters:format(jpeg)/pic1246781.jpg")!)
        XCTAssertFalse(parsedItems[0].description.isEmpty)

        XCTAssertEqual(parsedItems[1].id, "2")
        XCTAssertEqual(parsedItems[1].name, "Game: Carcassonne")
        XCTAssertEqual(parsedItems[1].names, [
            Name(kind: .primary, value: "Game: Carcassonne"),
            Name(kind: .alternate, value: "Carcassonne: Solo-Variante"),
        ])
        XCTAssertEqual(parsedItems[1].type, .boardgameFamily)
        XCTAssertEqual(parsedItems[1].thumbnail, URL(string: "https://cf.geekdo-images.com/c_pg0WfJKn7_P33AsDS5EA__thumb/img/8RgZmSChaxESGjIdhMeIg0C9OZk=/fit-in/200x150/filters:strip_icc()/pic453826.jpg")!)
        XCTAssertEqual(parsedItems[1].image, URL(string: "https://cf.geekdo-images.com/c_pg0WfJKn7_P33AsDS5EA__original/img/k2t0IHkPo0nzLadfSxXhtAzyU5I=/0x0/filters:format(jpeg)/pic453826.jpg")!)
        XCTAssertFalse(parsedItems[1].description.isEmpty)
    }
}
