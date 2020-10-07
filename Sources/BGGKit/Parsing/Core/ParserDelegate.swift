//
//  ParserDelegate.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

internal protocol ParserDelegate : XMLParserDelegate {
    var delegateStack: ParserDelegateStack? { get set }
    func didBecomeActive()
}

internal extension ParserDelegate {
    func didBecomeActive() {}
}
