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
    struct HotPublisher: Publisher {
        public typealias Output = [HotItem]
        public typealias Failure = Error

        private let xmlApi2: XMLApi2
        private let type: HotItem.Kind

        public init(xmlApi2: XMLApi2, type: HotItem.Kind) {
            self.xmlApi2 = xmlApi2
            self.type = type
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            let subscription = HotSubscription(xmlApi2: xmlApi2,
                                               type: type,
                                               target: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}

public extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func hotPublisher(for type: HotItem.Kind = .boardgame) -> HotPublisher {
        return HotPublisher(xmlApi2: self, type: type)
    }
}

private extension XMLApi2 {
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    class HotSubscription<Target: Subscriber>: Subscription where Target.Input == [HotItem], Target.Failure == Error {
        private let xmlApi2: XMLApi2
        private let type: HotItem.Kind
        private var target: Target?

        init(xmlApi2: XMLApi2,
             type: HotItem.Kind,
             target: Target) {
            self.xmlApi2 = xmlApi2
            self.type = type
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
            xmlApi2.hot(type: type) { [weak self] result in
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
