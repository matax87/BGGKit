//
//  FamilyItemsParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 22/01/2021.
//

import Foundation

internal final class FamilyItemsParser {
    fileprivate let xmlParser: XMLParser
    fileprivate let delegateStack: ParserDelegateStack
    fileprivate let familyItemsParser: ArrayParser<FamilyItemParser>

    fileprivate let queue: DispatchQueue

    init(xmlData: Data,
         queue: DispatchQueue = .init(label: "io.bggkit.parsing",
                                      qos: .userInitiated)) {
        self.queue = queue
        xmlParser = XMLParser(data: xmlData)
        delegateStack = ParserDelegateStack(xmlParser: xmlParser)
        familyItemsParser = ArrayParser(tagName: "items") { tag in
            guard tag == "item" else { return nil }
            return FamilyItemParser(tagName: tag)
        }
        delegateStack.push(familyItemsParser)
    }

    func parse(resultQueue: DispatchQueue = .main,
               completion completionHandler: @escaping (Result<[FamilyItem], Error>) -> Void) {
        queue.async {
            self.performParse(resultQueue: resultQueue,
                              completion: completionHandler)
        }
    }

    fileprivate func performParse(resultQueue: DispatchQueue = .main,
                                  completion completionHandler: @escaping (Result<[FamilyItem], Error>) -> Void) {
        if xmlParser.parse() {
            let items = familyItemsParser.result!.items
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
