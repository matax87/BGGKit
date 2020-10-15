//
//  ElementValueParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

internal class ElementValueParser<T>: NSObject, NodeParser {
    private let tagName: String
    private let transform: (String) -> T?

    var delegateStack: ParserDelegateStack?
    var result: T?

    private var foundCharacters = ""

    init(tagName: String, transform: @escaping (String) -> T?) {
        self.tagName = tagName
        self.transform = transform
    }

    func parser(_: XMLParser, didStartElement elementName: String, namespaceURI _: String?, qualifiedName _: String?, attributes _: [String: String] = [:]) {
        if elementName == tagName {
            foundCharacters = String()
        }
    }

    func parser(_: XMLParser, foundCharacters string: String) {
        foundCharacters += string
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
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
