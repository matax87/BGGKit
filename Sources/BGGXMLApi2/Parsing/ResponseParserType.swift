//
//  ResponseParserType.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 18/03/2021.
//

import Foundation

public protocol ResponseParserType {
    associatedtype Response

    static func parse(xmlData: Data) throws -> Response
}

public extension ResponseParserType {
    static func parse(
        xmlData: Data,
        onQueue: DispatchQueue = .global(qos: .background),
        completionQueue _: DispatchQueue = .main,
        completionHandler: @escaping (Result<Response, Error>) -> Void
    ) {
        onQueue.async {
            do {
                let parseResult = try parse(xmlData: xmlData)
                completionHandler(.success(parseResult))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
