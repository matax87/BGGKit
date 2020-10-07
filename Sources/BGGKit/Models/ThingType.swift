//
//  ThingType.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Foundation

public protocol ThingType: Identifiable {
    var id: String { get }
    var name: String { get }
    var thumbnail: URL? { get }
}

