//
//  NodeParser.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 02/10/2020.
//

import Foundation

public protocol NodeParser: StackableParser {
    associatedtype Item
    var result: Item? { get }
}
