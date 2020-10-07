//
//  HotItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 01/10/2020.
//

import Foundation

public struct HotItem: PublishedThing {
    public let id: String
    let name: String
    let thumbnail: URL?
    let yearPublished: Int?

    let rank: Int
}
