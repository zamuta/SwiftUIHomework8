//
//  SwiftUIHomework5App.swift
//  Shared
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import SwiftUI

@main
struct SwiftUIHomework5App: App {
    init() {
        ServiceLocator.shared.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
