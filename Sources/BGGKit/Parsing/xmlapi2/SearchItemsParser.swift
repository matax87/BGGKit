//
//  SearchItemsParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation

internal final class SearchItemsParser {
    
    fileprivate let xmlParser: XMLParser
    fileprivate let delegateStack: ParserDelegateStack
    fileprivate let searchItemsParser: ArrayParser<SearchItemParser>
    
    fileprivate let queue: DispatchQueue
    
    init(xmlData: Data,
         queue: DispatchQueue = .init(label: "io.bggkit.parsing",
                                      qos: .userInitiated)) {
        self.queue = queue
        xmlParser = XMLParser(data: xmlData)
        delegateStack = ParserDelegateStack(xmlParser: xmlParser)
        searchItemsParser = ArrayParser(tagName: "items") { tag in
            guard tag == "item" else { return nil }
            return SearchItemParser(tagName: tag)
        }
        delegateStack.push(searchItemsParser)
    }
    
    func parse(resultQueue: DispatchQueue = .main,
               completion completionHandler: @escaping (Result<[SearchItem], Error>) -> Void) {
        queue.async {
            self.performParse(resultQueue: resultQueue,
                              completion: completionHandler)
        }
        
    }
    
    fileprivate func performParse(resultQueue: DispatchQueue = .main,
                                  completion completionHandler: @escaping (Result<[SearchItem], Error>) -> Void) {
        if xmlParser.parse() {
            let items = searchItemsParser.result!.items
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
