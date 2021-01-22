//
//  XMLApi2.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

// MARK: - Types

public typealias AsyncResult<T> = (Result<T, Error>) -> Void
public typealias AsyncCollectionResult<T> = (Result<[T], Error>) -> Void

// MARK: - NetworkError

public enum NetworkError: Error {
    case invalidResponse(URLResponse)
    case invalidHttpStatus(Int)
}

// MARK: - XMLApi2

public final class XMLApi2 {
    // MARK: Private Stored Properties

    private let scheme: String
    private let baseUrl: String
    private let queue = DispatchQueue(
        label: "io.bggkit.xmlapi2",
        qos: .userInitiated
    )

    // MARK: Initialization

    public init(scheme: String = "https",
                baseUrl: String = "www.boardgamegeek.com") {
        self.scheme = scheme
        self.baseUrl = baseUrl
    }
}

// MARK: Thing Items API

public extension XMLApi2 {
    struct ThingOptions: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let versions = ThingOptions(rawValue: 1 << 0)
        public static let videos = ThingOptions(rawValue: 1 << 1)
        public static let stats = ThingOptions(rawValue: 1 << 2)
        public static let historical = ThingOptions(rawValue: 1 << 3)
        public static let marketplace = ThingOptions(rawValue: 1 << 4)
        public static let comments = ThingOptions(rawValue: 1 << 5)
        public static let ratingComments = ThingOptions(rawValue: 1 << 6)

        public static let all: ThingOptions = [
            .versions,
            .videos,
            .stats,
            .historical,
            .marketplace,
            .comments,
            .ratingComments
        ]
    }

    func thing(ids: [String],
               types: [ThingItem.Kind] = [.boardgame],
               options: ThingOptions = [],
               page pageOrNil: Int? = nil,
               pageSize pageSizeOrNil: Int? = nil,
               resultQueue: DispatchQueue = .main,
               completion completionHandler: @escaping AsyncCollectionResult<ThingItem>) {
        let page = pageOrNil.flatMap { max(0, $0) }
        let pageSize = pageSizeOrNil.flatMap { min(100, max(10, $0)) }
        let queryParameters: [QueryParameter] = [
            (name: "id", value: ids.joined(separator: ",")),
            (name: "type", value: types.joined(separator: ",")),
            options.contains(.versions) ? (name: "versions", value: "1") : nil,
            options.contains(.videos) ? (name: "videos", value: "1") : nil,
            options.contains(.stats) ? (name: "stats", value: "1") : nil,
            options.contains(.historical) ? (name: "historical", value: "1") : nil,
            options.contains(.marketplace) ? (name: "marketplace", value: "1") : nil,
            options.contains(.comments) ? (name: "comments", value: "1") : nil,
            options.contains(.ratingComments) ? (name: "ratingcomments", value: "1") : nil,
            page.flatMap { (name: "page", value: "\($0)") },
            pageSize.flatMap { (name: "pagesize", value: "\($0)") }
        ]
        .compactMap { $0 }
        call(endpoint: "thing",
             queryParameters: queryParameters) { [weak self] result in
            guard let self = self
            else { return }

            do {
                let xmlData = try result.get()
                let parser = ThingItemsParser(xmlData: xmlData,
                                              queue: self.queue)
                parser.parse(resultQueue: resultQueue,
                             completion: completionHandler)
            } catch {
                resultQueue.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}

// MARK: Family Items API

public extension XMLApi2 {
    func family(ids: [String],
                types: [String] = [],
                resultQueue: DispatchQueue = .main,
                completion completionHandler: @escaping AsyncCollectionResult<FamilyItem>) {
        let queryParameters: [QueryParameter] = [
            (name: "id", value: ids.joined(separator: ",")),
            (name: "type", value: types.joined(separator: ","))
        ]
        call(endpoint: "family",
             queryParameters: queryParameters) { [weak self] result in
            guard let self = self
            else { return }

            do {
                let xmlData = try result.get()
                let parser = FamilyItemsParser(xmlData: xmlData,
                                               queue: self.queue)
                parser.parse(resultQueue: resultQueue,
                             completion: completionHandler)
            } catch {
                resultQueue.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}

// MARK: Hot APIs

public extension XMLApi2 {
    func hot(type: HotItem.Kind = .boardgame,
             resultQueue: DispatchQueue = .main,
             completion completionHandler: @escaping AsyncCollectionResult<HotItem>) {
        call(endpoint: "hot",
             queryParameters: [(name: "type", value: type.rawValue)]) { [weak self] result in
            guard let self = self
            else { return }

            do {
                let xmlData = try result.get()
                let parser = HotItemsParser(xmlData: xmlData,
                                            queue: self.queue)
                parser.parse(resultQueue: resultQueue,
                             completion: completionHandler)
            } catch {
                resultQueue.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}

// MARK: Search APIs

public extension XMLApi2 {
    func search(query: String,
                matchExactly: Bool = false,
                types: [SearchItem.Kind] = [.boardgame],
                resultQueue: DispatchQueue = .main,
                completion completionHandler: @escaping AsyncCollectionResult<SearchItem>) {
        call(endpoint: "search",
             queryParameters: [
                 (name: "query", value: query),
                 (name: "type", value: types.joined(separator: ",")),
                 matchExactly ? (name: "exact", value: "1") : nil
             ]
             .compactMap { $0 }) { [weak self] result in
            guard let self = self
            else { return }

            do {
                let xmlData = try result.get()
                let parser = SearchItemsParser(xmlData: xmlData,
                                               queue: self.queue)
                parser.parse(resultQueue: resultQueue,
                             completion: completionHandler)
            } catch {
                resultQueue.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}

// MARK: Private APIs

private extension XMLApi2 {
    typealias QueryParameter = (name: String, value: String)

    func url(endpoint: String,
             queryParameters: [QueryParameter] = []) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseUrl
        components.path = "/xmlapi2/\(endpoint)"
        components.queryItems = queryParameters.map { param in
            URLQueryItem(name: param.name, value: param.value)
        }
        return components.url!
    }

    func handle(data: Data?,
                response: URLResponse?,
                error: Error?,
                completion completionHandler: @escaping AsyncResult<Data>) {
        guard error == nil else {
            return completionHandler(.failure(error!))
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            let responseError = NetworkError.invalidResponse(response!)
            return completionHandler(.failure(responseError))
        }

        let httpStatus = httpResponse.statusCode
        guard 200 ... 299 ~= httpStatus else {
            let statusError = NetworkError.invalidHttpStatus(httpStatus)
            return completionHandler(.failure(statusError))
        }

        completionHandler(.success(data!))
    }

    func call(endpoint: String,
              queryParameters: [QueryParameter] = [],
              completion completionHandler: @escaping AsyncResult<Data>) {
        let requestUrl = url(endpoint: endpoint,
                             queryParameters: queryParameters)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: requestUrl) { [weak self] data, response, error in
            self?.handle(data: data,
                         response: response,
                         error: error,
                         completion: completionHandler)
        }
        task.resume()
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
