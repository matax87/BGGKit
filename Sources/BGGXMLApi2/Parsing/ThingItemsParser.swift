//
//  ThingItemsParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation
import StackParsing

internal final class ThingItemsParser: ResponseParserType {
    static func parse(xmlData: Data) throws -> [ThingItem] {
        try Parser(xmlData: xmlData).parse()
    }
}

private extension ThingItemsParser {
    final class Parser {
        private let xmlParser: XMLParser
        private let stack: ParsersStack
        private let arrayParser: ArrayParser<ThingItemParser>

        init(xmlData: Data) {
            xmlParser = XMLParser(data: xmlData)
            stack = ParsersStack(xmlParser: xmlParser)
            arrayParser = ArrayParser(tagName: "items") { tag in
                guard tag == "item"
                else { return nil }
                return ThingItemParser(tagName: tag)
            }
            stack.push(arrayParser)
        }

        func parse() throws -> [ThingItem] {
            guard xmlParser.parse()
            else { throw xmlParser.parserError! }

            return arrayParser.result!.items
        }
    }
}
