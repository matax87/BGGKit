//
//  FamilyItemsParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 22/01/2021.
//

import Foundation
import StackParsing

internal final class FamilyItemsParser: ResponseParserType {
    static func parse(xmlData: Data) throws -> [FamilyItem] {
        try Parser(xmlData: xmlData).parse()
    }
}

private extension FamilyItemsParser {
    final class Parser {
        private let xmlParser: XMLParser
        private let stack: ParsersStack
        private let arrayParser: ArrayParser<FamilyItemParser>

        init(xmlData: Data) {
            xmlParser = XMLParser(data: xmlData)
            stack = ParsersStack(xmlParser: xmlParser)
            arrayParser = ArrayParser(tagName: "items") { tag in
                guard tag == "item"
                else { return nil }
                return FamilyItemParser(tagName: tag)
            }
            stack.push(arrayParser)
        }

        func parse() throws -> [FamilyItem] {
            guard xmlParser.parse()
            else { throw xmlParser.parserError! }

            return arrayParser.result!.items
        }
    }
}
