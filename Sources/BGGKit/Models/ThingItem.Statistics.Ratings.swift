//
//  ThingItem.Statistics.Ratings.swift
//
//
//  Created by Matteo Matassoni on 15/10/2020.
//

import Foundation

public extension ThingItem.Statistics {
    struct Ratings {
        public let usersRated: Int
        public let average: Double
        public let bayesAverage: Double
        public let ranks: [Rank]
        public let stddev: Double
        public let median: Double
        public let owned: Int
        public let trading: Int
        public let wanting: Int
        public let wishing: Int
        public let numberOfComments: Int
        public let numberOfWeights: Int
        public let averageWeight: Double
    }
}
