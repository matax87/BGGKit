//
//  PublishedThing.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation

public protocol PublishedThing: ThingType {
    public var yearPublished: Int? { get }
}
