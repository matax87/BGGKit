//
//  EndpointTests.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 29/03/2021.
//

@testable import BGGXMLApi2
import XCTest

final class EndpointTests: XCTestCase {
    private let scheme = "https"
    private let baseUrl = "baseUrl"
    private let port = 42

    static var allTests = [
        ("testFamilyEndpointWithoutIdsTypes", testFamilyEndpointWithoutIdsTypes),
        ("testFamilyEndpointWithId", testFamilyEndpointWithId),
        ("testFamilyEndpointWithIds", testFamilyEndpointWithIds)
    ]

    func testFamilyEndpointWithoutIdsTypes() throws {
        // Given
        let endpoint = Endpoint.family(ids: [], types: [])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/family"
        )
    }

    func testFamilyEndpointWithId() throws {
        // Given
        let endpoint = Endpoint.family(ids: ["42"], types: [])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/family?id=42"
        )
    }

    func testFamilyEndpointWithIds() throws {
        // Given
        let endpoint = Endpoint.family(ids: ["42", "12"], types: [])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/family?id=42,12"
        )
    }

    func testFamilyEndpointWithType() throws {
        // Given
        let endpoint = Endpoint.family(ids: [], types: [.boardgameFamily])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/family?type=boardgamefamily"
        )
    }

    func testFamilyEndpointWithTypes() throws {
        // Given
        let endpoint = Endpoint.family(ids: [], types: [.boardgameFamily, .rpg])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/family?type=boardgamefamily,rpg"
        )
    }

    func testFamilyEndpointWithIdsTypes() throws {
        // Given
        let endpoint = Endpoint.family(
            ids: ["42", "12"],
            types: [.boardgameFamily, .rpg]
        )

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/family?id=42,12&type=boardgamefamily,rpg"
        )
    }

    func testHotEndpointWitoutTypes() throws {
        // Given
        let endpoint = Endpoint.hot(types: [])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/hot"
        )
    }

    func testHotEndpointWithType() throws {
        // Given
        let endpoint = Endpoint.hot(types: [.boardgame])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/hot?type=boardgame"
        )
    }

    func testHotEndpointWithTypes() throws {
        // Given
        let endpoint = Endpoint.hot(types: [.boardgame, .rpg])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/hot?type=boardgame,rpg"
        )
    }

    func testThingsEndpointWithoutIdsTypes() throws {
        // Given
        let endpoint = Endpoint.things(ids: [], types: [])

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/things"
        )
    }

    func testSearchEndpointWithoutTypes() throws {
        // Given
        let endpoint = Endpoint.search(
            query: "aGame",
            types: [],
            matchExactly: false
        )

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/search?query=aGame"
        )
    }

    func testSearchEndpointWithType() throws {
        // Given
        let endpoint = Endpoint.search(
            query: "aGame",
            types: [.boardgame],
            matchExactly: false
        )

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/search?query=aGame&type=boardgame"
        )
    }

    func testSearchEndpointWithTypes() throws {
        // Given
        let endpoint = Endpoint.search(
            query: "aGame",
            types: [.boardgame, .boardgameExpansion],
            matchExactly: false
        )

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/search?query=aGame&type=boardgame,boardgameexpansion"
        )
    }

    func testSearchEndpointWithMatchExactly() throws {
        // Given
        let endpoint = Endpoint.search(
            query: "aGame",
            types: [.boardgame],
            matchExactly: true
        )

        // When
        let url = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl,
            port: port
        )

        // Then
        XCTAssertEqual(
            url.absoluteString,
            "\(scheme)://\(baseUrl):\(port)/xmlapi2/search?query=aGame&type=boardgame&exact=1"
        )
    }
}
