//
//  FamilyItemParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 22/01/2021.
//

import Foundation
import StackParsing

internal final class FamilyItemParser: NSObject, NodeParser {
    private let tagName: String

    private var id: String!
    private var kind: FamilyItem.Kind!
    private var names: [Name] = []
    private let thumbnailParser = URLElementValueParser(tagName: "thumbnail")
    private let imageParser = URLElementValueParser(tagName: "image")
    private let nameParser = NameParser(tagName: "name")
    private let descriptionParser = StringElementValueParser(tagName: "description")

    var stack: ParsersStack?
    private var currentParser: StackableParser?
    var result: FamilyItem?

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
            kind = attributeDict["type"]
                .flatMap(FamilyItem.Kind.init(rawValue:))
            return
        }

        switch elementName {
        case "image":
            currentParser = imageParser
            stack?.push(imageParser)
            imageParser.parser(parser,
                               didStartElement: elementName,
                               namespaceURI: namespaceURI,
                               qualifiedName: qName,
                               attributes: attributeDict)
        case "thumbnail":
            currentParser = thumbnailParser
            stack?.push(thumbnailParser)
            thumbnailParser.parser(parser,
                                   didStartElement: elementName,
                                   namespaceURI: namespaceURI,
                                   qualifiedName: qName,
                                   attributes: attributeDict)
        case "description":
            currentParser = descriptionParser
            stack?.push(descriptionParser)
            descriptionParser.parser(parser,
                                     didStartElement: elementName,
                                     namespaceURI: namespaceURI,
                                     qualifiedName: qName,
                                     attributes: attributeDict)
        case "name":
            currentParser = nameParser
            stack?.push(nameParser)
            nameParser.parser(parser,
                              didStartElement: elementName,
                              namespaceURI: namespaceURI,
                              qualifiedName: qName,
                              attributes: attributeDict)
        default:
            break
        }
    }

    func parser(_: XMLParser,
                didEndElement elementName: String,
                namespaceURI _: String?,
                qualifiedName _: String?) {
        if elementName == tagName {
            result = FamilyItem(id: id,
                                type: kind,
                                thumbnail: thumbnailParser.result,
                                image: imageParser.result,
                                names: names,
                                description: descriptionParser.result!)
            stack?.pop()
        }
    }

    func didBecomeActive() {
        if currentParser === nameParser,
           let name = nameParser.result {
            names.append(name)
        }
    }
}
