//
//  ElementAttributeValueParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

internal class ElementAttributeValueParser<T> : NSObject, NodeParser {
    private let tagName: String
    private let transform: (String) -> T?

    var delegateStack: ParserDelegateStack?
    var result: T?

    init(tagName: String, transform: @escaping (String) -> T?) {
        self.tagName = tagName
        self.transform = transform
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == tagName {
            result = attributeDict["value"].flatMap(transform)
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == tagName {
            delegateStack?.pop()
        }
    }
}

internal final class StringElementAttributeValueParser: ElementAttributeValueParser<String> {

    init(tagName: String) {
        super.init(tagName: tagName) { $0 }
    }

}

internal final class IntElementAttributeValueParser: ElementAttributeValueParser<Int> {

    init(tagName: String) {
        super.init(tagName: tagName, transform: Int.init)
    }

}

internal final class URLElementAttributeValueParser: ElementAttributeValueParser<URL> {

    init(tagName: String) {
        super.init(tagName: tagName, transform: URL.init)
    }

}

internal final class DoubleElementAttributeValueParser: ElementAttributeValueParser<Double> {

    init(tagName: String) {
        super.init(tagName: tagName, transform: Double.init)
    }

}
