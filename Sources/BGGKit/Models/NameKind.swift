//
//  NameKind.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public struct NameKind: Hashable {
    public let rawValue: String
    
    static let primary = NameKind(rawValue: "primary")
    static let alternate = NameKind(rawValue: "alternate")
}
