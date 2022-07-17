//
//  ContentView.swift
//  Shared
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import SwiftUI

enum MainTab {
    case TextTab, HistoryTab
}

struct ContentView: View {
    @State var selectedTab = MainTab.TextTab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                TextScreenView()
            }
            .tabItem {
                Text("Text Input")
            }.tag(MainTab.TextTab)
            NavigationView {
                HistoryScreenView()
            }
            .tabItem {
                Text("History")
            }.tag(MainTab.HistoryTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
