//
//  FamilyPublisherTests.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 07/10/2020.
//

@testable import BGGKit
import Combine
import XCTest

@available(iOS 13.0, *)
@available(OSX 10.15, *)
final class FamilyPublisherTests: XCTestCase {
    private var cancellable: AnyCancellable!

    static var allTests = [
        ("test", test)
    ]

    func test() {
        let xmlApi2 = XMLApi2()
        let expectation = XCTestExpectation(description: "BGG Family")
        let ids = ["1", "2"]
        cancellable = xmlApi2.familyPublisher(ids: ids)
            .sink(receiveCompletion: {
                      print("Received completion: \($0).")

                  },
                  receiveValue: { items in
                      XCTAssertTrue(items.count == ids.count)
                      XCTAssertEqual(items[0].id, ids[0])
                      XCTAssertEqual(items[1].id, ids[1])
                      expectation.fulfill()
                  })
        wait(for: [expectation], timeout: 3.0)
    }
}
