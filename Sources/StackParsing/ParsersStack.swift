//
//  ParsersStack.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

public final class ParsersStack {
    private var parsers: [StackableParser] = []
    private let xmlParser: XMLParser

    public init(xmlParser: XMLParser) {
        self.xmlParser = xmlParser
    }

    public func push(_ parser: StackableParser) {
        parser.stack = self
        xmlParser.delegate = parser
        parsers.append(parser)
    }

    public func pop() {
        parsers.removeLast()
        if let next = parsers.last {
            xmlParser.delegate = next
            next.didBecomeActive()
        } else {
            xmlParser.delegate = nil
        }
    }
}
