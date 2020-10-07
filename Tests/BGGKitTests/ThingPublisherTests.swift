//
//  ThingPublisherTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 07/10/2020.
//

import XCTest
import Combine
@testable import BGGKit

@available(iOS 13.0, *)
@available(OSX 10.15, *)
final class ThingPublisherTests: XCTestCase {

    private var cancellable: AnyCancellable!

    static var allTests = [
        ("test", test),
    ]
    
    func test() {
        let xmlApi2 = XMLApi2()
        let expectation = XCTestExpectation(description: "BGG Hot")
        let ids = ["1", "2"]
        cancellable = xmlApi2.thingPublisher(ids: ids)
            .sink(receiveCompletion: {
            print ("Received completion: \($0).")
            
        },
        receiveValue: { items in
            XCTAssertTrue(items.count == ids.count)
            XCTAssertEqual(items[0].id, ids[0])
            XCTAssertEqual(items[1].id, ids[1])
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
}
