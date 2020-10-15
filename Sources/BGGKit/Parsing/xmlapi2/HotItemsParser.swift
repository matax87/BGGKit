//
//  HotItemsParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

internal final class HotItemsParser {
    fileprivate let xmlParser: XMLParser
    fileprivate let delegateStack: ParserDelegateStack
    fileprivate let hotItemsParser: ArrayParser<HotItemParser>

    fileprivate let queue: DispatchQueue

    init(xmlData: Data,
         queue: DispatchQueue = .init(label: "io.bggkit.parsing",
                                      qos: .userInitiated)) {
        self.queue = queue
        xmlParser = XMLParser(data: xmlData)
        delegateStack = ParserDelegateStack(xmlParser: xmlParser)
        hotItemsParser = ArrayParser(tagName: "items") { tag in
            guard tag == "item" else { return nil }
            return HotItemParser(tagName: tag)
        }
        delegateStack.push(hotItemsParser)
    }

    func parse(resultQueue: DispatchQueue = .main,
               completion completionHandler: @escaping (Result<[HotItem], Error>) -> Void) {
        queue.async {
            self.performParse(resultQueue: resultQueue,
                              completion: completionHandler)
        }
    }

    fileprivate func performParse(resultQueue: DispatchQueue = .main,
                                  completion completionHandler: @escaping (Result<[HotItem], Error>) -> Void) {
        if xmlParser.parse() {
            let items = hotItemsParser.result!.items
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
