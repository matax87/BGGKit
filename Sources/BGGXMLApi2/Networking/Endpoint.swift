//
//  Endpoint.swift
//
//
//  Created by Matteo Matassoni on 17/03/2021.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []

    internal func buildURL(scheme: String = "https",
                           baseUrl: String = "www.boardgamegeek.com",
                           port: Int? = nil) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseUrl
        components.port = port
        components.path = "/xmlapi2" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems

        guard let url = components.url
        else { preconditionFailure("Invalid URL components: \(components)") }

        return url
    }

    static func things(ids: [String],
                       types: [ThingItem.Kind] = [.boardgame],
                       options: ThingRequestOptions = [],
                       page: Int? = nil,
                       pageSize: Int? = nil) -> Self {
        return Endpoint(
            path: "/things",
            queryItems: [
                !ids.isEmpty ?
                    URLQueryItem(
                        name: "id",
                        value: ids.joined(separator: ",")
                    ) :
                    nil,
                !types.isEmpty ?
                    URLQueryItem(
                        name: "type",
                        value: types.joined(separator: ",")
                    ) :
                    nil,
                options.contains(.versions) ?
                    URLQueryItem(
                        name: "versions",
                        value: "1"
                    ) :
                    nil,
                options.contains(.videos) ?
                    URLQueryItem(
                        name: "videos",
                        value: "1"
                    ) :
                    nil,
                options.contains(.stats) ?
                    URLQueryItem(
                        name: "stats",
                        value: "1"
                    ) :
                    nil,
                options.contains(.historical) ?
                    URLQueryItem(
                        name: "historical",
                        value: "1"
                    ) :
                    nil,
                options.contains(.marketplace) ?
                    URLQueryItem(
                        name: "marketplace",
                        value: "1"
                    ) :
                    nil,
                options.contains(.comments) ?
                    URLQueryItem(
                        name: "comments",
                        value: "1"
                    ) :
                    nil,
                options.contains(.ratingComments) ?
                    URLQueryItem(
                        name: "ratingcomments",
                        value: "1"
                    ) :
                    nil,
                page.flatMap { URLQueryItem(
                    name: "page",
                    value: "\($0)"
                ) },
                pageSize.flatMap { URLQueryItem(
                    name: "pagesize",
                    value: "\($0)"
                ) }
            ]
            .compactMap { $0 }
        )
    }

    static func family(ids: [String],
                       types: [FamilyItem.Kind]) -> Self {
        Endpoint(
            path: "/family",
            queryItems: [
                !ids.isEmpty ?
                    URLQueryItem(
                        name: "id",
                        value: ids.joined(separator: ",")
                    ) :
                    nil,
                !types.isEmpty ?
                    URLQueryItem(
                        name: "type",
                        value: types.joined(separator: ",")
                    ) :
                    nil
            ]
            .compactMap { $0 }
        )
    }

    static func hot(types: [HotItem.Kind] = [.boardgame]) -> Self {
        Endpoint(
            path: "/hot",
            queryItems: [
                !types.isEmpty ?
                    URLQueryItem(
                        name: "type",
                        value: types.joined(separator: ",")
                    ) :
                    nil
            ]
            .compactMap { $0 }
        )
    }

    static func search(
        query: String,
        types: [SearchItem.Kind] = [.boardgame],
        matchExactly: Bool = false
    ) -> Self {
        Endpoint(
            path: "/search",
            queryItems: [
                URLQueryItem(
                    name: "query",
                    value: query
                ),
                !types.isEmpty ?
                    URLQueryItem(
                        name: "type",
                        value: types.joined(separator: ",")
                    ) :
                    nil,
                matchExactly ?
                    URLQueryItem(
                        name: "exact",
                        value: "1"
                    ) :
                    nil
            ]
            .compactMap { $0 }
        )
    }
}

private extension Collection where Iterator.Element == HotItem.Kind {
    func joined(separator: String = "") -> String {
        map { $0.rawValue }.joined(separator: separator)
    }
}

private extension Collection where Iterator.Element == ThingItem.Kind {
    func joined(separator: String = "") -> String {
        map { $0.rawValue }.joined(separator: separator)
    }
}

private extension Collection where Iterator.Element == SearchItem.Kind {
    func joined(separator: String = "") -> String {
        map { $0.rawValue }.joined(separator: separator)
    }
}

private extension Collection where Iterator.Element == FamilyItem.Kind {
    func joined(separator: String = "") -> String {
        map { $0.rawValue }.joined(separator: separator)
    }
}
