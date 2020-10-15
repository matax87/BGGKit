//
//  HotPublisherTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import XCTest
import Combine
@testable import BGGKit

@available(iOS 13.0, *)
@available(OSX 10.15, *)
final class HotPublisherTests: XCTestCase {

    private var cancellable: AnyCancellable!

    static var allTests = [
        ("test", test),
    ]
    
    func test() {
        let xmlApi2 = XMLApi2()
        let expectation = XCTestExpectation(description: "BGG Hot")
        cancellable = xmlApi2.hotPublisher().sink(receiveCompletion: {
            print ("Received completion: \($0).")
            
        },
        receiveValue: { items in
            XCTAssertFalse(items.isEmpty)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
}
