//
//  ThingType.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public protocol ThingType: Identifiable {
    public var id: String { get }
    public var name: String { get }
    public var thumbnail: URL? { get }
}

