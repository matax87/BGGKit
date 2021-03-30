//
//  ThingItem.Statistics.Ratings.Rank.swift
//
//
//  Created by Matteo Matassoni on 15/10/2020.
//

import Foundation

public extension ThingItem.Statistics.Ratings {
    struct Rank {
        public let type: Kind
        public let id: String
        public let name: Name
        public let friendlyName: String
        public let value: Int?
        public let bayesAverage: Double?

        public init(
            type: ThingItem.Statistics.Ratings.Rank.Kind,
            id: String,
            name: ThingItem.Statistics.Ratings.Rank.Name,
            friendlyName: String,
            value: Int?,
            bayesAverage: Double?
        ) {
            self.type = type
            self.id = id
            self.name = name
            self.friendlyName = friendlyName
            self.value = value
            self.bayesAverage = bayesAverage
        }
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
