//
//  FamilyItem.Kind.swift
//
//
//  Created by Matteo Matassoni on 25/01/2021.
//

import Foundation

public extension FamilyItem {
    enum Kind: String, CaseIterable {
        case rpg
        case rpgPeriodical = "rpgperiodical"
        case boardgameFamily = "boardgamefamily"
    }
}
