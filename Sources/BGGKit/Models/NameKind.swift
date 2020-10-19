//
//  NameKind.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public struct NameKind: Hashable {
    public let rawValue: String

    public static let primary = NameKind(rawValue: "primary")
    public static let alternate = NameKind(rawValue: "alternate")
}
