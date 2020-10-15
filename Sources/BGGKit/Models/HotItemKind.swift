//
//  ItemKind.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation

public enum HotItemKind: String, CaseIterable {
    case boardgame
    case rpg
    case videogame
    case boardGamePerson = "boardgameperson"
    case rpgPerson = "rpgperson"
    case boardgameCompany = "boardgamecompany"
    case rpgCompany = "rpgcompany"
    case videogameCompany = "videogamecompany"
}
