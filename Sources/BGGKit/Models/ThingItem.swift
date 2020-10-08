//
//  ThingItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public struct ThingItem: PublishedThing {
    public let id: String
    public let names: [(NameKind, String)]
    public let thumbnail: URL?
    public let image: URL?
    public let type: ItemKind
    public let description: String
    public let yearPublished: String?

    public var name: String {
        names.first { $0.0 == .primary }!.1
    }
}
