//
//  WidgetEntryView.swift
//  HomeworkWidgetExtension
//
//  Created by Mikhail Kanshin on 28.06.2022.
//

import SwiftUI

struct WidgetEntryView : View {
    var entry: WidgetEntry
    
    var body: some View {
        let suffixes = entry.suffixes.joined(separator: ", ")
        let text = suffixes.count > 0 ? "Suffixes: \(suffixes)" : "No Suffixes"
        VStack {
            Text(text)
                .font(.footnote)
            HStack {
                Link("To Main", destination: WidgetLink.main)
                Link("To Suffixes", destination: WidgetLink.suffixes)
            }
            .foregroundColor(.blue)
        }
    }
}
