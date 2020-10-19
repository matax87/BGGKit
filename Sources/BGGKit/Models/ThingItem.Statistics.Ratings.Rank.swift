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

        public static let subtype = Kind(rawValue: "subtype")
        public static let family = Kind(rawValue: "family")
    }
}

public extension ThingItem.Statistics.Ratings.Rank {
    struct Name: Hashable {
        public let rawValue: String

        public static let boardgame = Name(rawValue: "boardgame")
        public static let abstracts = Name(rawValue: "abstracts")
        public static let cgs = Name(rawValue: "cgs")
        public static let childrensGames = Name(rawValue: "childrensgames")
        public static let familyGames = Name(rawValue: "familygames")
        public static let partyGames = Name(rawValue: "partygames")
        public static let strategyGames = Name(rawValue: "strategygames")
        public static let thematic = Name(rawValue: "thematic")
        public static let wargames = Name(rawValue: "wargames")
    }
}
