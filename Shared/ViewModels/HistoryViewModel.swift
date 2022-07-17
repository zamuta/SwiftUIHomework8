//
//  HistoryViewModel.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation
import SwiftUI
import Combine

class HistoryViewModel: ObservableObject {
    @InjectedService private var historyService: HistoryService
    
    @Published var history: [HistoryModel] = []

    var scheduler: JobScheduler<HandlerJob<Void>> = .init()
    //private(set) var isLoading: Bool = false
    private(set) var isTesting: Bool = false
    
    func fetchHistory() {
        //guard !isLoading else { return }
        //isLoading = true
        self.history.removeAll()
        for text in historyService.history {
            let item = HistoryModel()
            item.text = text
            self.history.append(item)
        }
        //isLoading = false
    }
    
    func testHistory() {
        guard !isTesting else { return }
        isTesting = true
        scheduler.completionHandler = { [weak self] jobs in
            guard let self = self else { return }
            self.isTesting = false
            self.objectWillChange.send()
        }
        for item in history {
            let job = HandlerJob({ [weak item, weak self] in
                guard let item = item else { return }
                guard let self = self else { return }
                let start = CFAbsoluteTimeGetCurrent()
                for _ in 0..<1000 {
                    _ = item.text.suffixies()
                }
                let end = CFAbsoluteTimeGetCurrent()
                let measureTime = end - start
                DispatchQueue.main.async {
                    item.lastMeasureTime = measureTime / 1000
                    self.objectWillChange.send()
                }
            })
            scheduler.add(job)
        }
        scheduler.executeAll()
    }
}
