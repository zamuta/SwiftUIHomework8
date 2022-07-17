//
//  ContentView.swift
//  Shared
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State var isSuffixScreenActive : Bool = false
    
    var body: some View {
        NavigationView {
            TextScreenView(isSuffixScreenActive: $isSuffixScreenActive)
        }
        .onOpenURL { url in
            if url == WidgetLink.main {
                isSuffixScreenActive = false
            }
            else if url == WidgetLink.suffixes {
                isSuffixScreenActive = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
