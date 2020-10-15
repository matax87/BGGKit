//
//  ThingItemsParserTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGKit
import XCTest

final class ThingItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParsingWithoutStatistic", testParsingWithoutStatistic),
        ("testParsingWithStatistic", testParsingWithStatistic)
    ]

    func testParsingWithoutStatistic() {
        let xmlFileUrl = Bundle.module.url(forResource: "thingItems1",
                                           withExtension: "xml")!
        let xmlData = try! Data(contentsOf: xmlFileUrl)
        let parser = ThingItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Thing Items")
        parser.parse { result in
            do {
                defer {
                    expectation.fulfill()
                }
                let items = try result.get()
                XCTAssertEqual(items.count, 1)

                let item = try XCTUnwrap(items.first)
                XCTAssertEqual(item.id, "13")
                XCTAssertEqual(item.name, "Catan")
                XCTAssertEqual(item.type, .boardgame)
                XCTAssertEqual(item.thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/8a9HeqFydO7Uun_le9bXWPnidcA=/fit-in/200x150/filters:strip_icc()/pic2419375.jpg")!)
                XCTAssertEqual(item.image, URL(string: "https://cf.geekdo-images.com/original/img/A-0yDJkve0avEicYQ4HoNO-HkK8=/0x0/pic2419375.jpg")!)
                XCTAssertFalse(item.description.isEmpty)
                XCTAssertEqual(item.minPlayers, 3)
                XCTAssertEqual(item.maxPlayers, 4)
                XCTAssertEqual(item.playingTime, 120)
                XCTAssertEqual(item.minPlayTime, 60)
                XCTAssertEqual(item.maxPlayTime, 120)
                XCTAssertEqual(item.minAge, 10)
                XCTAssertNil(item.statistics)
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testParsingWithStatistic() {
        let xmlFileUrl = Bundle.module.url(forResource: "thingItems2",
                                           withExtension: "xml")!
        let xmlData = try! Data(contentsOf: xmlFileUrl)
        let parser = ThingItemsParser(xmlData: xmlData)
        let expectation = XCTestExpectation(description: "Parse BGG Thing Items")
        parser.parse { result in
            do {
                defer {
                    expectation.fulfill()
                }
                let items = try result.get()
                XCTAssertEqual(items.count, 1)

                let item = try XCTUnwrap(items.first)
                XCTAssertEqual(item.id, "13")
                XCTAssertEqual(item.name, "Catan")
                XCTAssertEqual(item.type, .boardgame)
                XCTAssertEqual(item.thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/8a9HeqFydO7Uun_le9bXWPnidcA=/fit-in/200x150/filters:strip_icc()/pic2419375.jpg")!)
                XCTAssertEqual(item.image, URL(string: "https://cf.geekdo-images.com/original/img/A-0yDJkve0avEicYQ4HoNO-HkK8=/0x0/pic2419375.jpg")!)
                XCTAssertFalse(item.description.isEmpty)
                XCTAssertEqual(item.minPlayers, 3)
                XCTAssertEqual(item.maxPlayers, 4)
                XCTAssertEqual(item.playingTime, 120)
                XCTAssertEqual(item.minPlayTime, 60)
                XCTAssertEqual(item.maxPlayTime, 120)
                XCTAssertEqual(item.minAge, 10)

                let statistics = try XCTUnwrap(item.statistics)
                XCTAssertEqual(statistics.page, 1)

                let ratings = statistics.ratings
                XCTAssertEqual(ratings.usersRated, 97360)
                XCTAssertEqual(ratings.average, 7.16055)
                XCTAssertEqual(ratings.bayesAverage, 6.99815)
                XCTAssertEqual(ratings.stddev, 1.47924)
                XCTAssertEqual(ratings.median, 0)
                XCTAssertEqual(ratings.owned, 146_719)
                XCTAssertEqual(ratings.trading, 1852)
                XCTAssertEqual(ratings.wanting, 477)
                XCTAssertEqual(ratings.wishing, 5403)
                XCTAssertEqual(ratings.numberOfComments, 17998)
                XCTAssertEqual(ratings.numberOfWeights, 7220)
                XCTAssertEqual(ratings.averageWeight, 2.3252)
                XCTAssertEqual(ratings.ranks.count, 3)
                XCTAssertEqual(ratings.ranks[0].id, "1")
                XCTAssertEqual(ratings.ranks[0].type, .subtype)
                XCTAssertEqual(ratings.ranks[0].name, .boardgame)
                XCTAssertEqual(ratings.ranks[0].friendlyName, "Board Game Rank")
                XCTAssertEqual(ratings.ranks[0].value, 384)
                XCTAssertEqual(ratings.ranks[0].bayesAverage, 6.99815)
                XCTAssertEqual(ratings.ranks[1].id, "5497")
                XCTAssertEqual(ratings.ranks[1].type, .family)
                XCTAssertEqual(ratings.ranks[1].name, .strategyGames)
                XCTAssertEqual(ratings.ranks[1].friendlyName, "Strategy Game Rank")
                XCTAssertEqual(ratings.ranks[1].value, 353)
                XCTAssertEqual(ratings.ranks[1].bayesAverage, 6.87603)
                XCTAssertEqual(ratings.ranks[2].id, "5499")
                XCTAssertEqual(ratings.ranks[2].type, .family)
                XCTAssertEqual(ratings.ranks[2].name, .familyGames)
                XCTAssertEqual(ratings.ranks[2].friendlyName, "Family Game Rank")
                XCTAssertEqual(ratings.ranks[2].value, 109)
                XCTAssertEqual(ratings.ranks[2].bayesAverage, 6.94273)
            } catch {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
