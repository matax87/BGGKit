//
//  client.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

// MARK: - Client's Interfaces

protocol ThingService {
    func thing(
        ids: [String],
        types: [ThingItem.Kind],
        options: ThingRequestOptions,
        page: Int?,
        pageSize: Int?,
        completionQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ThingItem], Error>) -> Void
    )
}

extension ThingService {
    func thing(
        ids: [String],
        types: [ThingItem.Kind] = [.boardgame],
        options: ThingRequestOptions = [],
        page: Int? = nil,
        pageSize: Int? = nil,
        completionQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<[ThingItem], Error>) -> Void
    ) {
        thing(
            ids: ids,
            types: types,
            options: options,
            page: page,
            pageSize: pageSize,
            completionQueue: completionQueue,
            completionHandler: completionHandler
        )
    }

    func thing(
        id: String,
        types: [ThingItem.Kind] = [.boardgame],
        options: ThingRequestOptions = [],
        page: Int? = nil,
        pageSize: Int? = nil,
        completionQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<[ThingItem], Error>) -> Void
    ) {
        thing(
            ids: [id],
            types: types,
            options: options,
            page: page,
            pageSize: pageSize,
            completionQueue: completionQueue,
            completionHandler: completionHandler
        )
    }
}

protocol FamilyServiceType {
    func family(
        ids: [String],
        types: [FamilyItem.Kind],
        completionQueue: DispatchQueue,
        completionHandler: @escaping (Result<[FamilyItem], Error>) -> Void
    )
}

extension FamilyServiceType {
    func family(
        ids: [String],
        types: [FamilyItem.Kind] = [.boardgameFamily],
        completionQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<[FamilyItem], Error>) -> Void
    ) {
        family(
            ids: ids,
            types: types,
            completionQueue: completionQueue,
            completionHandler: completionHandler
        )
    }

    func family(
        id: String,
        types: [FamilyItem.Kind] = [.boardgameFamily],
        completionQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<[FamilyItem], Error>) -> Void
    ) {
        family(
            ids: [id],
            types: types,
            completionQueue: completionQueue,
            completionHandler: completionHandler
        )
    }
}

protocol HotService {
    func hot(
        types: [HotItem.Kind],
        completionQueue: DispatchQueue,
        completionHandler: @escaping (Result<[HotItem], Error>) -> Void
    )
}

extension HotService {
    func hot(
        types: [HotItem.Kind] = [.boardgame],
        completionQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<[HotItem], Error>) -> Void
    ) {
        hot(
            types: types,
            completionQueue: completionQueue,
            completionHandler: completionHandler
        )
    }
}

protocol SearchServiceType {
    func search(
        query: String,
        types: [SearchItem.Kind],
        matchExactly: Bool,
        completionQueue: DispatchQueue,
        completionHandler: @escaping (Result<[SearchItem], Error>) -> Void
    )
}

extension SearchServiceType {
    func search(
        query: String,
        types: [SearchItem.Kind] = [.boardgame],
        matchExactly: Bool = false,
        completionQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<[SearchItem], Error>) -> Void
    ) {
        search(
            query: query,
            types: types,
            matchExactly: matchExactly,
            completionQueue: completionQueue,
            completionHandler: completionHandler
        )
    }
}

// MARK: - Client

final class Client {
    // MARK: Private Stored Properties

    private let scheme: String
    private let baseUrl: String
    private let urlSession: URLSession

    // MARK: Initialization

    public init(
        scheme: String = "https",
        baseUrl: String = "www.boardgamegeek.com",
        urlSession: URLSession = .shared
    ) {
        self.scheme = scheme
        self.baseUrl = baseUrl
        self.urlSession = urlSession
    }

    // MARK: Public APIs

    public func fetch<T, P: ResponseParserType>(
        endpoint: Endpoint,
        responseParser: P.Type,
        completionQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) where P.Response == T {
        let requestUrl = endpoint.buildURL(
            scheme: scheme,
            baseUrl: baseUrl
        )
        let task = urlSession
            .dataTask(with: requestUrl) { data, response, taskError in
                let error = taskError ?? response
                    .flatMap { $0 as? HTTPURLResponse }
                    .flatMap { self.handleNetworkResponse(response: $0) }
                switch (data, error) {
                case let (_, error?):
                    completionHandler(.failure(error))
                case let (data?, _):
                    responseParser.parse(
                        xmlData: data,
                        completionQueue: completionQueue,
                        completionHandler: completionHandler
                    )
                case (nil, nil):
                    completionHandler(.failure(NetworkError.dataError))
                }
            }
        task.resume()
    }
}

// MARK: ThingServiceType

extension Client: ThingService {
    public func thing(
        ids: [String],
        types: [ThingItem.Kind],
        options: ThingRequestOptions,
        page: Int?,
        pageSize: Int?,
        completionQueue _: DispatchQueue,
        completionHandler: @escaping (Result<[ThingItem], Error>) -> Void
    ) {
        fetch(
            endpoint: .things(
                ids: ids,
                types: types,
                options: options,
                page: page,
                pageSize: pageSize
            ),
            responseParser: ThingItemsParser.self,
            completionHandler: completionHandler
        )
    }
}

// MARK: FamilyServiceType

extension Client: FamilyServiceType {
    public func family(
        ids: [String],
        types: [FamilyItem.Kind],
        completionQueue _: DispatchQueue,
        completionHandler: @escaping (Result<[FamilyItem], Error>) -> Void
    ) {
        fetch(
            endpoint: .family(
                ids: ids,
                types: types
            ),
            responseParser: FamilyItemsParser.self,
            completionHandler: completionHandler
        )
    }
}

// MARK: HotServiceType

extension Client: HotService {
    public func hot(
        types: [HotItem.Kind],
        completionQueue _: DispatchQueue,
        completionHandler: @escaping (Result<[HotItem], Error>) -> Void
    ) {
        fetch(
            endpoint: .hot(types: types),
            responseParser: HotItemsParser.self,
            completionHandler: completionHandler
        )
    }
}

// MARK: SearchServiceType

extension Client: SearchServiceType {
    public func search(
        query: String,
        types: [SearchItem.Kind],
        matchExactly: Bool,
        completionQueue _: DispatchQueue,
        completionHandler: @escaping (Result<[SearchItem], Error>) -> Void
    ) {
        fetch(
            endpoint: .search(
                query: query,
                types: types,
                matchExactly: matchExactly
            ),
            responseParser: SearchItemsParser.self,
            completionHandler: completionHandler
        )
    }
}

// MARK: Private APIs

private extension Client {
    func handleNetworkResponse(response: HTTPURLResponse) -> NetworkError? {
        switch response.statusCode {
        case 200 ... 299:
            return nil
        case 300 ... 399:
            return .redirectionError
        case 400 ... 499:
            return .clientError
        case 500 ... 599:
            return .serverError
        case 600:
            return .invalidRequest
        default:
            return .unknownError
        }
    }
}
