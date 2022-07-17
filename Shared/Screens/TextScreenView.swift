//
//  TextScreenView.swift
//  SwiftUIHomework5
//
//  Created by Mikhail Kanshin on 19.06.2022.
//

import SwiftUI

struct TextScreenView: View {
    @State var text: String = TextSamples.sample1
    
    var body: some View {
        VStack {
            ZStack {
                TextEditor(text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .border(.gray)
            }
            NavigationLink(destination: SuffixScreenView(text: text)) {
                Text("NEXT")
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.leading)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(.yellow)
                    .cornerRadius(15)
            }
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct TextScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TextScreenView()
    }
}
