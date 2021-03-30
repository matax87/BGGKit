//
//  SearchItem.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation

public struct SearchItem: PublishedItem {
    public let id: String
    public let name: String
    public let thumbnail: URL?
    public let yearPublished: Int?

    public let type: Kind
    public let isAlternateName: Bool
}
