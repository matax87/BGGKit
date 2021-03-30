//
//  PublishedThing.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 05/10/2020.
//

import Foundation

public protocol PublishedItem: BaseItem {
    var yearPublished: Int? { get }
}
