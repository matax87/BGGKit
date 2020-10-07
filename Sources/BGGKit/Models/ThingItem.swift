//
//  ThingItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public struct ThingItem: PublishedThing {
    public let id: String
    let names: [(NameKind, String)]
    let thumbnail: URL?
    let image: URL?
    let type: ItemKind
    let description: String
    let yearPublished: Int?

    var name: String {
        names.first { $0.0 == .primary }!.1
    }
}
