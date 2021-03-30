//
//  HotItem.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 01/10/2020.
//

import Foundation

public struct HotItem: PublishedItem {
    public let id: String
    public let name: String
    public let thumbnail: URL?
    public let yearPublished: Int?

    public let rank: Int
}
