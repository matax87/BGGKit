//
//  XMLApi2+FamilyPublisher.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 07/10/2020.
//

import Combine
import Foundation

public extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    struct FamilyPublisher: Publisher {
        public typealias Output = [FamilyItem]
        public typealias Failure = Error

        private let xmlApi2: XMLApi2
        private let ids: [String]
        private let types: [FamilyItem.Kind]

        public init(xmlApi2: XMLApi2,
                    ids: [String],
                    types: [FamilyItem.Kind] = []) {
            self.xmlApi2 = xmlApi2
            self.ids = ids
            self.types = types
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            let subscription = FamilySubscription(xmlApi2: xmlApi2,
                                                  ids: ids,
                                                  types: types,
                                                  target: subscriber)
            subscriber.receive(subscription: subscription)
            subscription.call()
        }
    }
}

public extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func familyPublisher(ids: [String],
                         types: [FamilyItem.Kind] = []) -> FamilyPublisher {
        return FamilyPublisher(xmlApi2: self,
                               ids: ids,
                               types: types)
    }

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func familyPublisher(id: String,
                         types: [FamilyItem.Kind] = []) -> FamilyPublisher {
        return FamilyPublisher(xmlApi2: self,
                               ids: [id],
                               types: types)
    }
}

private extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    class FamilySubscription<Target: Subscriber>: Subscription where Target.Input == [FamilyItem], Target.Failure == Error {
        private let xmlApi2: XMLApi2
        private let ids: [String]
        private let types: [FamilyItem.Kind]
        private var target: Target?

        init(xmlApi2: XMLApi2,
             ids: [String],
             types: [FamilyItem.Kind] = [],
             target: Target) {
            self.xmlApi2 = xmlApi2
            self.ids = ids
            self.types = types
            self.target = target
        }

        func request(_: Subscribers.Demand) {
            // TODO: - Optionaly Adjust The Demand
        }

        func cancel() {
            target = nil
        }

        func call() {
            xmlApi2.family(ids: ids, types: types) { [weak self] result in
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
