//
//  ThingItem.Statistics.Ratings.Rank.swift
//
//
//  Created by Matteo Matassoni on 15/10/2020.
//

import Foundation

public extension ThingItem.Statistics.Ratings {
    struct Rank {
        let type: Kind
        let id: String
        let name: Name
        let friendlyName: String
        let value: Int
        let bayesAverage: Double
    }
}

public extension ThingItem.Statistics.Ratings.Rank {
    struct Kind: Hashable {
        public let rawValue: String

        static let subtype = Kind(rawValue: "subtype")
        static let family = Kind(rawValue: "family")
    }
}

public extension ThingItem.Statistics.Ratings.Rank {
    struct Name: Hashable {
        public let rawValue: String

        static let boardgame = Name(rawValue: "boardgame")
        static let abstracts = Name(rawValue: "abstracts")
        static let cgs = Name(rawValue: "cgs")
        static let childrensGames = Name(rawValue: "childrensgames")
        static let familyGames = Name(rawValue: "familygames")
        static let partyGames = Name(rawValue: "partygames")
        static let strategyGames = Name(rawValue: "strategygames")
        static let thematic = Name(rawValue: "thematic")
        static let wargames = Name(rawValue: "wargames")
    }
}
