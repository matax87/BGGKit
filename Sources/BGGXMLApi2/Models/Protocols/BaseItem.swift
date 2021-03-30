//
//  BaseItem.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public protocol BaseItem: Identifiable {
    var id: String { get }
    var name: String { get }
    var thumbnail: URL? { get }
}
