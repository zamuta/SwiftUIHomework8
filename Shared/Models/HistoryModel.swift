//
//  HistoryModel.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation

class HistoryModel: Equatable, Hashable {
    var text : String = ""
    var lastMeasureTime : TimeInterval? = nil
    
    static func == (lhs: HistoryModel, rhs: HistoryModel) -> Bool {
        return lhs.text == rhs.text && lhs.lastMeasureTime == rhs.lastMeasureTime
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(lastMeasureTime)
    }
}
