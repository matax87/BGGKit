//
//  StatisticsParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 14/10/2020.
//

import Foundation
import StackParsing

internal final class StatisticsParser: NSObject, NodeParser {
    private let tagName: String

    private var page: Int!
    private let ratingsParser = RatingsParser(tagName: "ratings")

    var stack: ParsersStack?
    var result: ThingItem.Statistics?

    init(tagName: String) {
        self.tagName = tagName
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String: String] = [:]) {
        if elementName == tagName {
            page = attributeDict["page"].flatMap(Int.init)
            return
        }

        switch elementName {
        case "ratings":
            stack?.push(ratingsParser)
            ratingsParser.parser(parser,
                                 didStartElement: elementName,
                                 namespaceURI: namespaceURI,
                                 qualifiedName: qName,
                                 attributes: attributeDict)
        default:
            break
        }
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
        if elementName == tagName {
            result = ThingItem.Statistics(page: page,
                                          ratings: ratingsParser.result!)
            stack?.pop()
        }
    }
}
