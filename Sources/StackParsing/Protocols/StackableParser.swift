//
//  StackableParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

public protocol StackableParser: XMLParserDelegate {
    var stack: ParsersStack? { get set }

    func willBecomeActive()
    func didBecomeActive()
}

public extension StackableParser {
    func willBecomeActive() {}

    func didBecomeActive() {}
}
