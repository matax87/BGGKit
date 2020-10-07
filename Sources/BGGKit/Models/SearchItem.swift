//
//  SearchItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation

public struct SearchItem: PublishedThing {
    public let id: String
    let name: String
    let thumbnail: URL?
    let yearPublished: Int?

    let type: ItemKind
    let isAlternateName: Bool
}
