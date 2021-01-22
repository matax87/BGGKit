//
//  FamilyItemsParserTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 22/01/2021.
//

@testable import BGGKit
import XCTest

final class FamilyItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParsing", testParsing)
    ]

    func testParsing() {
        let xmlFileUrl = Bundle.module.url(forResource: "familyItems",
                                           withExtension: "xml")!
        let xmlData = try! Data(contentsOf: xmlFileUrl)
        let parser = FamilyItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Family Items")
        parser.parse { result in
            do {
                defer {
                    expectation.fulfill()
                }
                let items = try result.get()
                XCTAssertEqual(items.count, 2)

                let testFamily = items[0]
                XCTAssertEqual(testFamily.id, "1")
                XCTAssertEqual(testFamily.name, "Test Family")
                XCTAssertEqual(testFamily.names, [
                    Name(kind: .primary, value: "Test Family"),
                    Name(kind: .alternate, value: "Another Test Family")
                ])
                XCTAssertEqual(testFamily.type, "boardgamefamily")
                XCTAssertEqual(testFamily.thumbnail, URL(string: "https://cf.geekdo-images.com/AKJnFj40lhCRU-T5WpQigw__thumb/img/8Td1xqSG6RqZ6PoijvQL0q5sCWY=/fit-in/200x150/filters:strip_icc()/pic1246781.jpg")!)
                XCTAssertEqual(testFamily.image, URL(string: "https://cf.geekdo-images.com/AKJnFj40lhCRU-T5WpQigw__original/img/2p1Kn54uXswvhkuoAzLDruE4J_4=/0x0/filters:format(jpeg)/pic1246781.jpg")!)
                XCTAssertFalse(testFamily.description.isEmpty)

                let gameCarcassonne = items[1]
                XCTAssertEqual(gameCarcassonne.id, "2")
                XCTAssertEqual(gameCarcassonne.name, "Game: Carcassonne")
                XCTAssertEqual(gameCarcassonne.names, [
                    Name(kind: .primary, value: "Game: Carcassonne"),
                    Name(kind: .alternate, value: "Carcassonne: Solo-Variante")
                ])
                XCTAssertEqual(gameCarcassonne.type, "boardgamefamily")
                XCTAssertEqual(gameCarcassonne.thumbnail, URL(string: "https://cf.geekdo-images.com/c_pg0WfJKn7_P33AsDS5EA__thumb/img/8RgZmSChaxESGjIdhMeIg0C9OZk=/fit-in/200x150/filters:strip_icc()/pic453826.jpg")!)
                XCTAssertEqual(gameCarcassonne.image, URL(string: "https://cf.geekdo-images.com/c_pg0WfJKn7_P33AsDS5EA__original/img/k2t0IHkPo0nzLadfSxXhtAzyU5I=/0x0/filters:format(jpeg)/pic453826.jpg")!)
                XCTAssertFalse(gameCarcassonne.description.isEmpty)
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
