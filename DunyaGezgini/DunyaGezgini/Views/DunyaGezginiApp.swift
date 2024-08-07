//
//  DunyaGezginiApp.swift
//  DunyaGezgini
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import SwiftUI

@main
struct DunyaGezginiApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
            ContentView()
                    .tabItem {
                        HStack {
                            Image(systemName: "thermometer")
                            Text("TAB_CONVERSION")
                        }
                    }
            MapView()
                    .tabItem {
                        HStack {
                            Image(systemName: "map")
                            Text("TAB_MAP")
                        }
                    }
            }
            .accentColor(.purple)
        }
    }
}
