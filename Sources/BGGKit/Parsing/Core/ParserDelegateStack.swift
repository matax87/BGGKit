//
//  ParserDelegateStack.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

internal final class ParserDelegateStack {
    private var parsers: [ParserDelegate] = []
    private let xmlParser: XMLParser

    init(xmlParser: XMLParser) {
        self.xmlParser = xmlParser
    }

    func push(_ parser: ParserDelegate) {
        parser.delegateStack = self
        xmlParser.delegate = parser
        parsers.append(parser)
    }

    func pop() {
        parsers.removeLast()
        if let next = parsers.last {
            xmlParser.delegate = next
            next.didBecomeActive()
        } else {
            xmlParser.delegate = nil
        }
    }
}
