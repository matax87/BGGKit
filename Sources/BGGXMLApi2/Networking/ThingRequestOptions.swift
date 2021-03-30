//
//  Endpoint.swift
//
//
//  Created by Matteo Matassoni on 17/03/2021.
//

import Foundation

struct ThingRequestOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let versions = ThingRequestOptions(rawValue: 1 << 0)
    public static let videos = ThingRequestOptions(rawValue: 1 << 1)
    public static let stats = ThingRequestOptions(rawValue: 1 << 2)
    public static let historical = ThingRequestOptions(rawValue: 1 << 3)
    public static let marketplace = ThingRequestOptions(rawValue: 1 << 4)
    public static let comments = ThingRequestOptions(rawValue: 1 << 5)
    public static let ratingComments = ThingRequestOptions(rawValue: 1 << 6)

    public static let all: ThingRequestOptions = [
        .versions,
        .videos,
        .stats,
        .historical,
        .marketplace,
        .comments,
        .ratingComments
    ]
}
