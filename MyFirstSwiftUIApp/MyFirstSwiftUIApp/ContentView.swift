//
//  ContentView.swift
//  MyFirstSwiftUIApp
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var isTurkish: Bool = true
    
    var body: some View {
        VStack {
            if isTurkish {
                Text("Merhaba Dünya!")
            } else {
                Text("Hello World!")
            }
            Button(action: {
                self.isTurkish.toggle()
            }, label: { Text(isTurkish ? "Hello" : "Merhaba") })
        }
        .padding()
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
