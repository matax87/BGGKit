//
//  SearchItemsParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation
import StackParsing

//
//  SearchItemsParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation
import StackParsing

internal final class SearchItemsParser: ResponseParserType {
    static func parse(xmlData: Data) throws -> [SearchItem] {
        try Parser(xmlData: xmlData).parse()
    }
}

private extension SearchItemsParser {
    final class Parser {
        private let xmlParser: XMLParser
        private let stack: ParsersStack
        private let arrayParser: ArrayParser<SearchItemParser>

        init(xmlData: Data) {
            xmlParser = XMLParser(data: xmlData)
            stack = ParsersStack(xmlParser: xmlParser)
            arrayParser = ArrayParser(tagName: "items") { tag in
                guard tag == "item" else { return nil }
                return SearchItemParser(tagName: tag)
            }
            stack.push(arrayParser)
        }

        func parse() throws -> [SearchItem] {
            guard xmlParser.parse()
            else { throw xmlParser.parserError! }

            return arrayParser.result!.items
        }
    }
}
