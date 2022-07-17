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
    @InjectedService private var historyService: HistoryService
    
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
        self.models = text.suffixies()
        historyService.add(text)
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
}
