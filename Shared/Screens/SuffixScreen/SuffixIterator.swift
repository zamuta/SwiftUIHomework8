//
//  SuffixIterator.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index

    init(string: String) {
        self.string = string
        self.offset = string.endIndex
    }

    mutating func next() -> Substring? {
        guard offset > string.startIndex else { return nil }
        offset = string.index(before: offset)
        return string.suffix(from: offset)
    }
}
