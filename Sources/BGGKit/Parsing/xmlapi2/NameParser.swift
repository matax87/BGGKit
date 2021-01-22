//
//  NameParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

internal class NameParser: NSObject, NodeParser {
    private let tagName: String

    var delegateStack: ParserDelegateStack?
    var result: Name?

    init(tagName: String) {
        self.tagName = tagName
    }

    func parser(_: XMLParser, didStartElement elementName: String, namespaceURI _: String?, qualifiedName _: String?, attributes attributeDict: [String: String] = [:]) {
        if elementName == tagName {
            if let kind = attributeDict["type"].flatMap(NameKind.init),
               let value = attributeDict["value"] {
                result = Name(kind: kind, value: value)
            }
        }
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
        if elementName == tagName {
            delegateStack?.pop()
        }
    }
}
