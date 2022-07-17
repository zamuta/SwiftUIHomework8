//
//  HistoryScreenView.swift
//  SwiftUIHomework5 (iOS)
//
//  Created by Mikhail Kanshin on 17.07.2022.
//

import SwiftUI

struct HistoryScreenView: View {
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.history, id: \.text) { item in
                let backgroundColor = viewModel.colorForItem(item)
                VStack(spacing: 8) {
                    Text(item.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                    Text((item.lastMeasureTime != nil) ? String(format: "%.2f ms", item.lastMeasureTime! * 1000) : "На очереди тестирования")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .background(backgroundColor)
            }
        }
        .listStyle(.plain)
        .padding()
        .navigationTitle("Suffix List")
        .onAppear {
            viewModel.fetchHistory()
            viewModel.testHistory()
        }
    }
}

struct HistoryScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreenView()
    }
}
