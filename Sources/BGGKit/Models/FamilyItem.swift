//
//  FamilyItem.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 22/01/2021.
//

import Foundation

public struct FamilyItem: BaseItem {
    public let id: String
    public let type: String
    public let thumbnail: URL?
    public let image: URL?
    public let names: [Name]
    public let description: String
    // TODO: links
}

public extension FamilyItem {
    var name: String {
        names.primaryName()!
    }
}
