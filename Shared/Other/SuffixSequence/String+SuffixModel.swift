//
//  String+SuffixModel.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import Foundation

extension String {
    func suffixies(minLen: UInt = 3, minCount: UInt = 2) -> [SuffixModel] {
        var models: [SuffixModel] = []
        let suffixes = suffixes(text: self)
        let suffixCounter = suffixConter(suffixes: suffixes)
        suffixCounter.keys.forEach { suffix in
            let model = SuffixModel(suffix: suffix, count: suffixCounter[suffix]!)
            models.append(model)
        }
        models = models.filter { $0.count >= minCount }
        return models
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
