//
//  HotItemsParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation
import StackParsing

internal final class HotItemsParser: ResponseParserType {
    static func parse(xmlData: Data) throws -> [HotItem] {
        try Parser(xmlData: xmlData).parse()
    }
}

private extension HotItemsParser {
    final class Parser {
        private let xmlParser: XMLParser
        private let stack: ParsersStack
        private let arrayParser: ArrayParser<HotItemParser>

        init(xmlData: Data) {
            xmlParser = XMLParser(data: xmlData)
            stack = ParsersStack(xmlParser: xmlParser)
            arrayParser = ArrayParser(tagName: "items") { tag in
                guard tag == "item" else { return nil }
                return HotItemParser(tagName: tag)
            }
            stack.push(arrayParser)
        }

        func parse() throws -> [HotItem] {
            guard xmlParser.parse()
            else { throw xmlParser.parserError! }

            return arrayParser.result!.items
        }
    }
}
