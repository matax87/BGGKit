//
//  ThingItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public struct ThingItem {
    public let id: String
    public let names: [(NameKind, String)]
    public let thumbnail: URL?
    public let image: URL?
    public let type: Kind
    public let description: String
    public let yearPublished: Int?
    public let minPlayers: Int
    public let maxPlayers: Int
    public let playingTime: Int
    public let minPlayTime: Int
    public let maxPlayTime: Int
    public let minAge: Int
    public let statistics: Statistics?

    public var name: String {
        names.first { $0.0 == .primary }!.1
    }
}
