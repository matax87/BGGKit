//
//  NameParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation
import StackParsing

internal class NameParser: NSObject, NodeParser {
    private let tagName: String

    var stack: ParsersStack?
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
            stack?.pop()
        }
    }
}
