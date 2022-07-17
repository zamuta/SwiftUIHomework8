//
//  WidgetBridge.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 28.06.2022.
//

import SwiftUI

final class WidgetBridge {
    static let shared: WidgetBridge = .init()
    private let userDefaults = UserDefaults(suiteName:"group.homework5")!
    
    var top10Array: [String] {
        set {
            userDefaults.set(newValue, forKey: "top10")
        }
        get {
            return userDefaults.object(forKey: "top10") as? [String] ?? []
        }
    }
}
