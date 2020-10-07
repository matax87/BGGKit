//
//  NameKind.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

struct NameKind: Hashable {
    static let primary = NameKind(rawValue: "primary")
    static let alternate = NameKind(rawValue: "alternate")

    let rawValue: String
}
