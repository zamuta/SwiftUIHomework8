//
//  SuffixModel.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import Foundation

class SuffixModel: Equatable, Hashable {
    var suffix: String
    var count: Int

    init(suffix: String, count: Int) {
        self.suffix = suffix
        self.count = count
    }
    
    static func == (lhs: SuffixModel, rhs: SuffixModel) -> Bool {
        return lhs.suffix == rhs.suffix && lhs.count == rhs.count
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(suffix)
        hasher.combine(count)
    }
}
