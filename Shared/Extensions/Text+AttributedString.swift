//
//  Text+AttributedString.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import SwiftUI

extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string)
        configure(&attributedString)
        self.init(attributedString)
    }
}
