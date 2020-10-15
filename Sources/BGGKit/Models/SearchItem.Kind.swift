//
//  SearchItem.Kind.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 13/10/2020.
//

import Foundation

public extension SearchItem {

    enum Kind: String, CaseIterable {
        case rpgItem = "rpgitem"
        case videogame = "videogame"
        case boardgame = "boardgame"
        case boardgameAccessory = "boardgameaccessory"
        case boardgameExpansion = "boardgameexpansion"
    }

}
