//
//  NameParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

internal class NameParser : NSObject, NodeParser {
    private let tagName: String
    
    var delegateStack: ParserDelegateStack?
    var result: (NameKind, String)?
    
    init(tagName: String) {
        self.tagName = tagName
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == tagName {
            if let type = attributeDict["type"].flatMap(NameKind.init),
               let value = attributeDict["value"] {
                result = (type, value)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == tagName {
            delegateStack?.pop()
        }
    }
}
