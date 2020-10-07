//
//  HotItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 01/10/2020.
//

import Foundation

public struct HotItem: PublishedThing {
    public let id: String
    public let name: String
    public let thumbnail: URL?
    public let yearPublished: Int?

    public let rank: Int
}
