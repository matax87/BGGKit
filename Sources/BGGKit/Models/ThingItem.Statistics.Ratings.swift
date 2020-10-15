//
//  ThingItem.Statistics.Ratings.swift
//  
//
//  Created by Matteo Matassoni on 15/10/2020.
//

import Foundation

public extension ThingItem.Statistics {

    struct Ratings {
        let usersRated: Int
        let average: Double
        let bayesAverage: Double
        let ranks: [Rank]
        let stddev: Double
        let median: Double
        let owned: Int
        let trading: Int
        let wanting: Int
        let wishing: Int
        let numberOfComments: Int
        let numberOfWeights: Int
        let averageWeight: Double
    }

}
