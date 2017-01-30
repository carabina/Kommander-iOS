//
//  Kommander.swift
//  Kommander
//
//  Created by Alejandro Ruperez Hernando on 26/1/17.
//  Copyright © 2017 Intelygenz. All rights reserved.
//

import Foundation

public class Kommander {

    private final let deliverer: Dispatcher
    private final let executor: Dispatcher

    public convenience init() {
        self.init(deliverer: nil, executor: nil)
    }

    public convenience init(executor: Dispatcher) {
        self.init(deliverer: nil, executor: executor)
    }

    public convenience init(deliverer: Dispatcher) {
        self.init(deliverer: deliverer, executor: nil)
    }

    public init(deliverer: Dispatcher?, executor: Dispatcher?) {
        self.deliverer = deliverer ?? CurrentDispatcher()
        self.executor = executor ?? Dispatcher()
    }

    public convenience init(name: String?, qos: QualityOfService?, maxConcurrentOperationCount: Int) {
        self.init(deliverer: nil, name: name, qos: qos, maxConcurrentOperationCount: maxConcurrentOperationCount)
    }

    public convenience init(name: String?, qos: DispatchQoS?, attributes: DispatchQueue.Attributes?, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency?, target: DispatchQueue?) {
        self.init(deliverer: nil, name: name, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, target: target)
    }

    public init(deliverer: Dispatcher?, name: String?, qos: QualityOfService?, maxConcurrentOperationCount: Int) {
        self.deliverer = deliverer ?? CurrentDispatcher()
        executor = Dispatcher(name: name, qos: qos, maxConcurrentOperationCount: maxConcurrentOperationCount)
    }

    public init(deliverer: Dispatcher?, name: String?, qos: DispatchQoS?, attributes: DispatchQueue.Attributes?, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency?, target: DispatchQueue?) {
        self.deliverer = deliverer ?? CurrentDispatcher()
        executor = Dispatcher(label: name, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, target: target)
    }

    public func makeKommand<T>(_ actionBlock: @escaping () throws -> T) -> Kommand<T> {
        return Kommand<T>(deliverer: deliverer, executor: executor, actionBlock: actionBlock)
    }

}
