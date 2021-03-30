//
//  ThingItemsParserTests.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

@testable import BGGXMLApi2
import XCTest

final class ThingItemsParserTests: XCTestCase {
    static var allTests = [
        ("testParseWithInvalidXML", testParseWithInvalidXML),
        ("testParseWithoutStatistic", testParseWithoutStatistic),
        ("testParseWithStatistic", testParseWithStatistic),
        ("testParseWithStatisticNotRanked", testParseWithStatisticNotRanked)
    ]

    func testParseWithInvalidXML() throws {
        // Given
        let xmlData = Data.invalidXml()

        // When/Then
        XCTAssertThrowsError(try ThingItemsParser.parse(xmlData: xmlData))
    }

    func testParseWithoutStatistic() throws {
        // Given
        let xmlData = loadResource(withName: "thingItems1", extension: "xml")

        // When
        let parsedItems = try ThingItemsParser.parse(xmlData: xmlData)

        // Then
        let parsedItem = try XCTUnwrap(parsedItems.first)
        XCTAssertEqual(parsedItem.id, "13")
        XCTAssertEqual(parsedItem.name, "Catan")
        XCTAssertEqual(parsedItem.type, .boardgame)
        XCTAssertEqual(parsedItem.thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/8a9HeqFydO7Uun_le9bXWPnidcA=/fit-in/200x150/filters:strip_icc()/pic2419375.jpg")!)
        XCTAssertEqual(parsedItem.image, URL(string: "https://cf.geekdo-images.com/original/img/A-0yDJkve0avEicYQ4HoNO-HkK8=/0x0/pic2419375.jpg")!)
        XCTAssertEqual(parsedItem.yearPublished, 1995)
        XCTAssertFalse(parsedItem.description.isEmpty)
        XCTAssertEqual(parsedItem.minPlayers, 3)
        XCTAssertEqual(parsedItem.maxPlayers, 4)
        XCTAssertEqual(parsedItem.playingTime, 120)
        XCTAssertEqual(parsedItem.minPlayTime, 60)
        XCTAssertEqual(parsedItem.maxPlayTime, 120)
        XCTAssertEqual(parsedItem.minAge, 10)
        XCTAssertNil(parsedItem.statistics)
    }

    func testParseWithStatistic() throws {
        // Given
        let xmlData = loadResource(withName: "thingItems2", extension: "xml")

        // When
        let parsedItems = try ThingItemsParser.parse(xmlData: xmlData)

        // Then
        let parsedItem = try XCTUnwrap(parsedItems.first)
        XCTAssertEqual(parsedItem.id, "13")
        XCTAssertEqual(parsedItem.name, "Catan")
        XCTAssertEqual(parsedItem.type, .boardgame)
        XCTAssertEqual(parsedItem.thumbnail, URL(string: "https://cf.geekdo-images.com/thumb/img/8a9HeqFydO7Uun_le9bXWPnidcA=/fit-in/200x150/filters:strip_icc()/pic2419375.jpg")!)
        XCTAssertEqual(parsedItem.image, URL(string: "https://cf.geekdo-images.com/original/img/A-0yDJkve0avEicYQ4HoNO-HkK8=/0x0/pic2419375.jpg")!)
        XCTAssertEqual(parsedItem.yearPublished, 1995)
        XCTAssertFalse(parsedItem.description.isEmpty)
        XCTAssertEqual(parsedItem.minPlayers, 3)
        XCTAssertEqual(parsedItem.maxPlayers, 4)
        XCTAssertEqual(parsedItem.playingTime, 120)
        XCTAssertEqual(parsedItem.minPlayTime, 60)
        XCTAssertEqual(parsedItem.maxPlayTime, 120)
        XCTAssertEqual(parsedItem.minAge, 10)

        let statistics = try XCTUnwrap(parsedItem.statistics)
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
    }

    func testParseWithStatisticNotRanked() throws {
        // Given
        let xmlData = loadResource(withName: "thingItems3", extension: "xml")
        let parsedItem: ThingItem

        // When
        let parsedItems = try ThingItemsParser.parse(xmlData: xmlData)

        // Then
        parsedItem = try XCTUnwrap(parsedItems.first)
        XCTAssertEqual(parsedItem.id, "317321")
        XCTAssertEqual(parsedItem.name, "Darkest Dungeon: The Board Game")
        XCTAssertEqual(parsedItem.type, .boardgame)
        XCTAssertEqual(parsedItem.thumbnail, URL(string: "https://cf.geekdo-images.com/k_JONJZe2vumR0FLCaiExQ__thumb/img/uCN9za7i94EyOXPtmuYcdWaGkXA=/fit-in/200x150/filters:strip_icc()/pic5634524.png")!)
        XCTAssertEqual(parsedItem.image, URL(string: "https://cf.geekdo-images.com/k_JONJZe2vumR0FLCaiExQ__original/img/1tkLYk0-2qdm1uLbbsyE25RGA1M=/0x0/pic5634524.png")!)
        XCTAssertFalse(parsedItem.description.isEmpty)
        XCTAssertEqual(parsedItem.minPlayers, 1)
        XCTAssertEqual(parsedItem.maxPlayers, 4)
        XCTAssertEqual(parsedItem.playingTime, 120)
        XCTAssertEqual(parsedItem.minPlayTime, 90)
        XCTAssertEqual(parsedItem.maxPlayTime, 120)
        XCTAssertEqual(parsedItem.minAge, 14)

        let statistics = try XCTUnwrap(parsedItem.statistics)
        XCTAssertEqual(statistics.page, 1)

        let ratings = statistics.ratings
        XCTAssertEqual(ratings.usersRated, 22)
        XCTAssertEqual(ratings.average, 7.40909)
        XCTAssertEqual(ratings.bayesAverage, 0)
        XCTAssertEqual(ratings.stddev, 3.56318)
        XCTAssertEqual(ratings.median, 0)
        XCTAssertEqual(ratings.owned, 2)
        XCTAssertEqual(ratings.trading, 0)
        XCTAssertEqual(ratings.wanting, 21)
        XCTAssertEqual(ratings.wishing, 384)
        XCTAssertEqual(ratings.numberOfComments, 11)
        XCTAssertEqual(ratings.numberOfWeights, 0)
        XCTAssertEqual(ratings.averageWeight, 0)
        XCTAssertEqual(ratings.ranks.count, 1)
        XCTAssertEqual(ratings.ranks[0].id, "1")
        XCTAssertEqual(ratings.ranks[0].type, .subtype)
        XCTAssertEqual(ratings.ranks[0].name, .boardgame)
        XCTAssertEqual(ratings.ranks[0].friendlyName, "Board Game Rank")
        XCTAssertNil(ratings.ranks[0].value)
        XCTAssertNil(ratings.ranks[0].bayesAverage)
    }
}
