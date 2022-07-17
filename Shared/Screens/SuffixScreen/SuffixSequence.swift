//
//  SuffixSequence.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import Foundation

struct SuffixSequence: Sequence {
    let string: String

    func makeIterator() -> SuffixIterator {
        SuffixIterator(string: string)
    }
}
