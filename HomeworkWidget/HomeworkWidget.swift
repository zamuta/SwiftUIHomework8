//
//  HomeworkWidget.swift
//  HomeworkWidget
//
//  Created by Mikhail Kanshin on 28.06.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date(), suffixes: ["Placeholder1", "Placeholder2"])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let entry = WidgetEntry(date: Date(), suffixes: ["Snapshot1", "Snapshot2"])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let nextDate = Calendar.current.date(byAdding: .second, value: 1, to: Date())!
        let entry = WidgetEntry(date: nextDate, suffixes: WidgetBridge.shared.top10Array)
        let timeline = Timeline(entries: [entry], policy: .after(nextDate))
        completion(timeline)
    }
}

@main
struct HomeworkWidget: Widget {
    let kind: String = "HomeworkWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Homework Widget")
        .description("This is Homework Widget.")
    }
}

struct HomeworkWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: WidgetEntry(date: Date(), suffixes: ["Preview1", "Preview2"]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
