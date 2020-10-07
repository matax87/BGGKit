//
//  ArrayParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

internal final class ArrayParser<Parser : NodeParser> : NSObject, NodeParser {

    struct Result<T> {
        let items: [T]
        let attributes: [String : String]
    }

    var result: Result<Parser.Item>?
    var delegateStack: ParserDelegateStack?

    private let tagName: String
    private let parserBuilder: (String) -> Parser?
    private var currentParser: Parser?
    private var items: [Parser.Item] = []
    private var attributes: [String : String] = [:]

    init(tagName: String, parserBuilder: @escaping (String) -> Parser?) {
        self.tagName = tagName
        self.parserBuilder = parserBuilder
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == tagName {
            return
        }

        attributes = attributeDict
        if let itemParser = parserBuilder(elementName) {
            currentParser = itemParser
            delegateStack?.push(itemParser)
            itemParser.parser?(parser, didStartElement: elementName, namespaceURI: namespaceURI, qualifiedName: qName, attributes: attributeDict)
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == tagName {
            result = Result(items: items, attributes: attributes)
            delegateStack?.pop()
        }
    }

    func didBecomeActive() {
        guard let item = currentParser?.result else { return }
        items.append(item)
    }
}
