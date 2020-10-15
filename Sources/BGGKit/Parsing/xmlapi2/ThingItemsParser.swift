//
//  ThingItemsParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

internal final class ThingItemsParser {
    fileprivate let xmlParser: XMLParser
    fileprivate let delegateStack: ParserDelegateStack
    fileprivate let thingItemsParser: ArrayParser<ThingItemParser>

    fileprivate let queue: DispatchQueue

    init(xmlData: Data,
         queue: DispatchQueue = .init(label: "io.bggkit.parsing",
                                      qos: .userInitiated)) {
        self.queue = queue
        xmlParser = XMLParser(data: xmlData)
        delegateStack = ParserDelegateStack(xmlParser: xmlParser)
        thingItemsParser = ArrayParser(tagName: "items") { tag in
            guard tag == "item" else { return nil }
            return ThingItemParser(tagName: tag)
        }
        delegateStack.push(thingItemsParser)
    }

    func parse(resultQueue: DispatchQueue = .main,
               completion completionHandler: @escaping (Result<[ThingItem], Error>) -> Void) {
        queue.async {
            self.performParse(resultQueue: resultQueue,
                              completion: completionHandler)
        }
    }

    fileprivate func performParse(resultQueue: DispatchQueue = .main,
                                  completion completionHandler: @escaping (Result<[ThingItem], Error>) -> Void) {
        if xmlParser.parse() {
            let items = thingItemsParser.result!.items
            resultQueue.async {
                completionHandler(.success(items))
            }
        } else {
            let error = xmlParser.parserError
            resultQueue.async {
                completionHandler(.failure(error!))
            }
        }
    }
}
