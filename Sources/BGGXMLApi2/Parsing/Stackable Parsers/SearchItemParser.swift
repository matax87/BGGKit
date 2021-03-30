//
//  HotItemParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation
import StackParsing

internal final class SearchItemParser: NSObject, NodeParser {
    private let tagName: String

    private var id: String!
    private var type: SearchItem.Kind!
    private var isAlternateName = false
    private let thumbnailParser = URLElementAttributeValueParser(tagName: "thumbnail")
    private let nameParser = StringElementAttributeValueParser(tagName: "name")
    private let yearPublishedParser = IntElementAttributeValueParser(tagName: "yearpublished")

    var stack: ParsersStack?
    var result: SearchItem?

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
            type = attributeDict["type"].flatMap(SearchItem.Kind.init)
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
            isAlternateName = attributeDict["type"] == "alternate"
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
            result = SearchItem(id: id,
                                name: nameParser.result!,
                                thumbnail: thumbnailParser.result,
                                yearPublished: yearPublishedParser.result,
                                type: type,
                                isAlternateName: isAlternateName)
            stack?.pop()
        }
    }
}