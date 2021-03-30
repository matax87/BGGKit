//
//  XCTestCase+Resource.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 29/03/2021.
//

import XCTest

extension XCTestCase {
    func loadResource(withName name: String, extension: String) -> Data {
        let bundle = Bundle.module
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
}
