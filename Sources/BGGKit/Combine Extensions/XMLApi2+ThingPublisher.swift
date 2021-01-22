//
//  XMLApi2+ThingPublisher.swift
//  BGGKit
//
//  Created by Matteo Matassoni on 07/10/2020.
//

import Combine
import Foundation

public extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    struct ThingPublisher: Publisher {
        public typealias Output = [ThingItem]
        public typealias Failure = Error

        private let xmlApi2: XMLApi2
        private let ids: [String]
        private let types: [ThingItem.Kind]
        private let options: XMLApi2.ThingOptions
        private let page: Int?
        private let pageSize: Int?

        public init(xmlApi2: XMLApi2,
                    ids: [String],
                    types: [ThingItem.Kind],
                    options: XMLApi2.ThingOptions,
                    page: Int?,
                    pageSize: Int?) {
            self.xmlApi2 = xmlApi2
            self.ids = ids
            self.types = types
            self.options = options
            self.page = page
            self.pageSize = pageSize
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            let subscription = ThingSubscription(xmlApi2: xmlApi2,
                                                 ids: ids,
                                                 types: types,
                                                 options: options,
                                                 page: page,
                                                 pageSize: pageSize,
                                                 target: subscriber)
            subscriber.receive(subscription: subscription)
            subscription.call()
        }
    }
}

public extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func thingPublisher(ids: [String],
                        types: [ThingItem.Kind] = [.boardgame],
                        options: ThingOptions = [],
                        page pageOrNil: Int? = nil,
                        pageSize pageSizeOrNil: Int? = nil) -> ThingPublisher {
        return ThingPublisher(xmlApi2: self,
                              ids: ids,
                              types: types,
                              options: options,
                              page: pageOrNil,
                              pageSize: pageSizeOrNil)
    }
}

private extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    class ThingSubscription<Target: Subscriber>: Subscription where Target.Input == [ThingItem], Target.Failure == Error {
        private let xmlApi2: XMLApi2
        private let ids: [String]
        private let types: [ThingItem.Kind]
        private let options: XMLApi2.ThingOptions
        private let page: Int?
        private let pageSize: Int?
        private var target: Target?

        init(xmlApi2: XMLApi2,
             ids: [String],
             types: [ThingItem.Kind],
             options: XMLApi2.ThingOptions,
             page: Int?,
             pageSize: Int?,
             target: Target) {
            self.xmlApi2 = xmlApi2
            self.ids = ids
            self.types = types
            self.options = options
            self.page = page
            self.pageSize = pageSize
            self.target = target
        }

        func request(_: Subscribers.Demand) {
            // TODO: - Optionaly Adjust The Demand
        }

        func cancel() {
            target = nil
        }

        func call() {
            xmlApi2.thing(ids: ids,
                          types: types,
                          options: options,
                          page: page,
                          pageSize: pageSize) { [weak self] result in
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
