//
//  HotItemParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation
import StackParsing

internal final class HotItemParser: NSObject, NodeParser {
    private let tagName: String

    private var id: String!
    private var rank: Int!
    private let thumbnailParser = URLElementAttributeValueParser(tagName: "thumbnail")
    private let nameParser = StringElementAttributeValueParser(tagName: "name")
    private let yearPublishedParser = IntElementAttributeValueParser(tagName: "yearpublished")

    var stack: ParsersStack?
    var result: HotItem?

    init(tagName: String) {
        self.tagName = tagName
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String: String] = [:]) {
        if elementName == tagName {
            id = attributeDict["id"]
            rank = attributeDict["rank"].flatMap(Int.init)
            return
        }

        switch elementName {
        case "thumbnail":
            stack?.push(thumbnailParser)
            thumbnailParser.parser(parser,
                                   didStartElement: elementName,
                                   namespaceURI: namespaceURI,
                                   qualifiedName: qName,
                                   attributes: attributeDict)
        case "name":
            stack?.push(nameParser)
            nameParser.parser(parser,
                              didStartElement: elementName,
                              namespaceURI: namespaceURI,
                              qualifiedName: qName,
                              attributes: attributeDict)
        case "yearpublished":
            stack?.push(yearPublishedParser)
            yearPublishedParser.parser(parser,
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
            result = HotItem(id: id,
                             name: nameParser.result!,
                             thumbnail: thumbnailParser.result,
                             yearPublished: yearPublishedParser.result,
                             rank: rank)
            stack?.pop()
        }
    }
}
