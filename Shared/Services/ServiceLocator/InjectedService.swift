//
//  InjectedService.swift
//  SwiftUIHomework (iOS)
//
//  Created by Mikhail Kanshin on 10.04.2022.
//

import Foundation

@propertyWrapper
public struct InjectedService<T> {
    private var service: T?

    public var wrappedValue: T {
        mutating get {
            if service == nil {
                service = ServiceLocator.shared.getService(T.self)
                if service == nil {
                    fatalError("Service not found")
                }
            }
            return service!
        }
    }
    
    public init(service: T? = nil) {
        self.service = service
    }
}
