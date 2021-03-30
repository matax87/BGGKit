//
//  XCTestCase+Await.swift
//  BGGXMLApi2
//
//  Created by Matteo Matassoni on 01/03/2021.
//

import XCTest

/// Source: https://www.swiftbysundell.com/articles/asyncawait-in-swift-unit-tests/
struct AwaitError: Error {}

extension XCTestCase {
    func await<T>(_ function: (@escaping (T) -> Void) -> Void) throws -> T {
        let expectation = self.expectation(description: "Async call")
        var result: T?

        function { value in
            result = value
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)

        guard let unwrappedResult = result else {
            throw AwaitError()
        }

        return unwrappedResult
    }

    // We'll add a typealias for our closure types, to make our
    // new method signature a bit easier to read.
    typealias Function<T> = (T) -> Void

    func await<A, R>(_ function: @escaping Function<(A, Function<R>)>,
                     calledWith argument: A) throws -> R {
        return try await { handler in
            function((argument, handler))
        }
    }
}
