//
//  SuffixViewModel.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import Foundation
import SwiftUI
import Combine

class SuffixViewModel: ObservableObject {
    @Published var searchSuffix: String = "" {
        didSet {
            isSearching = true
        }
    }
    @Published var invertOrder:  Bool = false {
        didSet {
            handleFilters(searchSuffix: searchSuffix, invertOrder: invertOrder)
        }
    }

    @Published private(set) var orderedArray: [SuffixModel] = []
    @Published private(set) var top10Array:   [SuffixModel] = []
    
    var isSearching: Bool = false
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        $searchSuffix
          .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
          .removeDuplicates()
          .sink(receiveValue: { [weak self] newValue in
              guard let self = self else { return }
              self.isSearching = false
              self.handleFilters(searchSuffix: newValue, invertOrder: self.invertOrder)
          })
          .store(in: &subscriptions)
    }
    
    private var text:   String? = nil
    private var models: [SuffixModel] = []
    
    func handle(text: String) {
        guard text != self.text else { return }
        var models: [SuffixModel] = []
        let suffixes = suffixes(text: text)
        let suffixCounter = suffixConter(suffixes: suffixes)
        suffixCounter.keys.forEach { suffix in
            let model = SuffixModel(suffix: suffix, count: suffixCounter[suffix]!)
            models.append(model)
        }
        models = models.filter { $0.count > 1 }
        self.models = models
        handleFilters(searchSuffix: searchSuffix, invertOrder: invertOrder)
    }
        
    private func handleFilters(searchSuffix: String, invertOrder: Bool) {
        orderedArray = models.sorted { $0.suffix < $1.suffix }
        top10Array = models.sorted { $0.count > $1.count }
        if top10Array.count > 10 {
            top10Array = Array(top10Array[0...10])
        }
        if invertOrder {
            orderedArray = orderedArray.reversed()
            //top10Array = top10Array.reversed()
        }
        if searchSuffix.count > 0 {
            orderedArray = orderedArray.filter { $0.suffix.range(of: searchSuffix.lowercased()) != nil }
            top10Array = top10Array.filter { $0.suffix.range(of: searchSuffix.lowercased()) != nil }
        }
    }
    
    private func suffixes(text: String, minLen: UInt = 3) -> [String] {
        guard text.count > 0 else { return [] }
        var suffixes: [String] = []
        let words = text.split { !$0.isLetter }
        for word in words {
            let sequence = SuffixSequence(string: String(word))
            for suffix in sequence {
                suffixes.append(String(suffix))
            }
        }
        suffixes = suffixes.map { $0.lowercased() }
        suffixes = suffixes.filter { $0.count >= minLen }
        return suffixes
    }
    
    private func suffixConter(suffixes: [String]) -> [String : Int] {
        var suffixCounter: [String: Int] = [:]
        for suffix in suffixes {
            let counter = suffixCounter[suffix]
            if counter == nil {
                suffixCounter[suffix] = 1
            } else {
                suffixCounter[suffix]! += 1
            }
        }
        return suffixCounter
    }
}
