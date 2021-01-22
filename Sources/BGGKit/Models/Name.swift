//
//  Name.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 22/01/2021.
//

import Foundation

public struct Name: Equatable {
    public let kind: NameKind
    public let value: String
}

extension Sequence where Iterator.Element == Name {
    func primaryName() -> String? {
        first { $0.kind == .primary }?.value
    }
}
