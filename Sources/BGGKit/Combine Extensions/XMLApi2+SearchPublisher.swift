//
//  XMLApi2+Combine.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 06/10/2020.
//

import Combine
import Foundation

public extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    struct SearchPublisher: Publisher {
        public typealias Output = [SearchItem]
        public typealias Failure = Error

        private let xmlApi2: XMLApi2
        private let query: String
        private let matchExactly: Bool
        private let types: [SearchItem.Kind]

        public init(xmlApi2: XMLApi2,
                    query: String,
                    matchExactly: Bool,
                    types: [SearchItem.Kind]) {
            self.xmlApi2 = xmlApi2
            self.query = query
            self.matchExactly = matchExactly
            self.types = types
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            let subscription = SearchSubscription(xmlApi2: xmlApi2,
                                                  query: query,
                                                  matchExactly: matchExactly,
                                                  types: types,
                                                  target: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}

public extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func searchPublisher(query: String,
                         matchExactly: Bool = false,
                         types: [SearchItem.Kind] = [.boardgame]) -> SearchPublisher {
        return SearchPublisher(xmlApi2: self,
                               query: query,
                               matchExactly: matchExactly,
                               types: types)
    }
}

private extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    class SearchSubscription<Target: Subscriber>: Subscription where Target.Input == [SearchItem], Target.Failure == Error {
        private let xmlApi2: XMLApi2
        private let query: String
        private let matchExactly: Bool
        private let types: [SearchItem.Kind]
        private var target: Target?

        init(xmlApi2: XMLApi2,
             query: String,
             matchExactly: Bool = false,
             types: [SearchItem.Kind],
             target: Target) {
            self.xmlApi2 = xmlApi2
            self.query = query
            self.matchExactly = matchExactly
            self.types = types
            self.target = target
            call()
        }

        func request(_: Subscribers.Demand) {
            // TODO: - Optionaly Adjust The Demand
        }

        func cancel() {
            target = nil
        }

        func call() {
            xmlApi2.search(query: query,
                           matchExactly: matchExactly,
                           types: types) { [weak self] result in
                do {
                    let items = try result.get()
                    _ = self?.target?.receive(items)
                } catch {
                    self?.target?.receive(completion: .failure(error))
                }
            }
        }
    }
}
