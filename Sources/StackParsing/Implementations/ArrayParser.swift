//
//  ArrayParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

public final class ArrayParser<Parser: NodeParser>: NSObject,
    NodeParser {
    public typealias ResultType = (
        items: [Parser.Item],
        attributes: [String: String]
    )

    public var result: ResultType?
    public var stack: ParsersStack?

    private let tagName: String
    private let parserBuilder: (String) -> Parser?
    private var itemsParser: Parser?
    private var items: [Parser.Item] = []
    private var attributes: [String: String] = [:]

    public init(
        tagName: String,
        parserBuilder: @escaping (String) -> Parser?
    ) {
        self.tagName = tagName
        self.parserBuilder = parserBuilder
    }

    // MARK: StackableParser

    public func didBecomeActive() {
        if let parsedItem = itemsParser?.result {
            items.append(parsedItem)
        }
    }

    // MARK: XMLParserDelegate

    public func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        if elementName == tagName {
            attributes = attributeDict
            return
        }

        if let itemParser = parserBuilder(elementName) {
            itemsParser = itemParser
            stack?.push(itemParser)
            itemParser.parser?(
                parser,
                didStartElement: elementName,
                namespaceURI: namespaceURI,
                qualifiedName: qName,
                attributes: attributeDict
            )
        }
    }

    public func parser(
        _: XMLParser,
        didEndElement elementName: String,
        namespaceURI _: String?, qualifiedName _: String?
    ) {
        if elementName == tagName {
            result = (items: items, attributes: attributes)
            stack?.pop()
        }
    }
}
