//
//  ServiceLocator.swift
//  SwiftUIHomework (iOS)
//
//  Created by Mikhail Kanshin on 10.04.2022.
//

import Foundation

public class ServiceLocator {
    static public let shared = ServiceLocator()
    
    private var services: [String: AnyObject] = [:]
    
    public func addService<T>(service: T) {
        let key = "\(T.self)"
        if services[key] == nil {
            services[key] = service as AnyObject
        }
    }
    
    public func getService<T>(_ type: T.Type) -> T? {
        let key = "\(T.self)"
        return services[key] as? T
    }
}
