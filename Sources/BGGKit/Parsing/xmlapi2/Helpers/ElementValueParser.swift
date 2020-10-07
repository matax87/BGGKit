//
//  ElementValueParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

internal class ElementValueParser<T> : NSObject, NodeParser {
    private let tagName: String
    private let transform: (String) -> T?

    var delegateStack: ParserDelegateStack?
    var result: T?

    private var foundCharacters = ""

    init(tagName: String, transform: @escaping (String) -> T?) {
        self.tagName = tagName
        self.transform = transform
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == tagName {
            foundCharacters = String()
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        foundCharacters += string
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == tagName {
            foundCharacters = foundCharacters
                .trimmingCharacters(in: .whitespacesAndNewlines)
            result = transform(foundCharacters)
            delegateStack?.pop()
        }
    }
}

internal final class StringElementValueParser: ElementValueParser<String> {

    init(tagName: String) {
        super.init(tagName: tagName) { $0 }
    }

}

internal final class IntElementValueParser: ElementValueParser<Int> {

    init(tagName: String) {
        super.init(tagName: tagName, transform: Int.init)
    }

}

internal final class URLElementValueParser: ElementValueParser<URL> {

    init(tagName: String) {
        super.init(tagName: tagName, transform: URL.init)
    }

}
