//
//  ServiceLocator+Configurator.swift
//  SwiftUIHomework (iOS)
//
//  Created by Mikhail Kanshin on 10.04.2022.
//

import Foundation

extension ServiceLocator {
    public func configure() {
        self.addService(service: HistoryService.shared)
    }
}
