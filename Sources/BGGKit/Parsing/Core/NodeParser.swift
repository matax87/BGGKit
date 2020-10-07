//
//  NodeParser.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

internal protocol NodeParser : ParserDelegate {
    associatedtype Item
    var result: Item? { get }
}
