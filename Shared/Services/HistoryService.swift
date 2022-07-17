//
//  FavoritesController.swift
//  SwiftUIHomework2 (iOS)
//
//  Created by Mikhail Kanshin on 26.03.2022.
//

import Foundation

public class HistoryService {
    static public let shared = HistoryService()
    
    private let kUserDefaultsHistoryKey = "history"
    public var history: [String] = [] // Array для сохранения порядка добавления
    
    public init() {
        history = UserDefaults.standard.object(forKey: kUserDefaultsHistoryKey) as? [String] ?? []
        if history.isEmpty {
            //add(TextSamples.sample1)
            add(TextSamples.sample2)
            add(TextSamples.sample3)
            add(TextSamples.sample4)
        }
    }
    
    public func add(_ text: String) {
        let index = history.firstIndex(of: text)
        if (index != nil) {
            history.remove(at: index!)
        }
        history.append(text)
        save()
    }
    
    public func remove(_ text: String) {
        let index = history.firstIndex(of: text)
        if (index != nil) {
            history.remove(at: index!)
        }
        save()
    }
    
    private func save() {
        UserDefaults.standard.set(history, forKey: kUserDefaultsHistoryKey)
    }
}
