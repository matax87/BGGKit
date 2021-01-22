//
//  ThingItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public struct ThingItem: PublishedItem {
    public init(id: String,
                names: [Name],
                thumbnail: URL?, image: URL?,
                type: ThingItem.Kind,
                description: String,
                yearPublished: Int?,
                minPlayers: Int,
                maxPlayers: Int,
                playingTime: Int,
                minPlayTime: Int,
                maxPlayTime: Int,
                minAge: Int,
                statistics: ThingItem.Statistics?) {
        self.id = id
        self.names = names
        self.thumbnail = thumbnail
        self.image = image
        self.type = type
        self.description = description
        self.yearPublished = yearPublished
        self.minPlayers = minPlayers
        self.maxPlayers = maxPlayers
        self.playingTime = playingTime
        self.minPlayTime = minPlayTime
        self.maxPlayTime = maxPlayTime
        self.minAge = minAge
        self.statistics = statistics
    }

    public let id: String
    public let names: [Name]
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
}

public extension ThingItem {
    var name: String {
        names.primaryName()!
    }
}
