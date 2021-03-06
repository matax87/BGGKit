//
//  ThingItem.Kind.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 13/10/2020.
//

import Foundation

public extension ThingItem {
    enum Kind: String, CaseIterable {
        case boardgame
        case boardgameExpansion = "boardgameexpansion"
        case boardgameAccessory = "boardgameaccessory"
        case videogame
        case rpgItem = "rpgitem"
        case rpgIssue = "rpgissue"
    }
}
