//
//  SearchItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation

public struct SearchItem: PublishedThing {
    public let id: String
    public let name: String
    public let thumbnail: URL?
    public let yearPublished: Int?

    public let type: ItemKind
    public let isAlternateName: Bool
}
