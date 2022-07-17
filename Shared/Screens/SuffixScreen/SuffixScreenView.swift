//
//  SuffixScreenView.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import SwiftUI

enum SuffixMenu: String, CaseIterable {
    case all   = "ALL"
    case top10 = "TOP10"
}

struct SuffixScreenView: View {
    let text: String
    
    @StateObject private var viewModel = SuffixViewModel()
    @State private var pickerSelection: SuffixMenu = .all
    
    var body: some View {
        VStack {
            VStack {
                Picker("", selection: $pickerSelection, content: {
                    ForEach(SuffixMenu.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                })
                .pickerStyle(SegmentedPickerStyle())
                Toggle("ASC/DESC", isOn: $viewModel.invertOrder)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .opacity(pickerSelection == .all ? 1 : 0)
            }
            List {
                let array: [SuffixModel] = pickerSelection == .all ? viewModel.orderedArray : viewModel.top10Array
                if (!viewModel.isSearching) {
                    ForEach(array, id: \.self) { model in
                        HStack {
                            Text(model.suffix) { string in
                                if let range = string.range(of: viewModel.searchSuffix) {
                                    string[range].foregroundColor = .blue
                                }
                            }
                            .fontWeight(.semibold)
                            Spacer()
                            Text("\(model.count)")
                        }
                    }
                }
            }
            .listStyle(.plain)
            Spacer()
        }
        .padding()
        .navigationTitle("Suffix List")
        .searchable(text: $viewModel.searchSuffix)
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .onAppear {
            viewModel.handle(text: text)
            WidgetBridge.shared.top10Array = viewModel.top10Array.map(){ $0.suffix }
        }
    }
}

struct SuffixScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = "Exorcizo te, immundissime spiritus, omnis incursio adversarii, omne phantasma, omnis legio, in nomine Domini nostri Jesu Christi eradicare, et effugare ab hoc plasmate Dei..."
        SuffixScreenView(text: sample)
    }
}
