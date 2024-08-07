//
//  ContentView.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var gameStore = GameStore()
    
    @State var gameToDelete: Game?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gameStore.games) { (game) in
                    NavigationLink(
                        destination: DetailView(
                            game: game,
                            gameStore: gameStore,
                            name: game.name,
                            price: game.priceInDollars
                        )
                        ) {
                            GameListItem(game: game)
                    }
                }
                .onDelete(perform: { indexSet in
                    self.gameToDelete = gameStore.game(at: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    gameStore.move(indices: indices, to: newOffset)
                })
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Used Games")
            .navigationBarItems(leading: EditButton(), trailing:Button(action: {
                gameStore.createGame()
            }, label: {
                Text("Add")
            }) )
            .animation(.easeIn)
            .actionSheet(item: $gameToDelete) { (game) -> ActionSheet in
                ActionSheet(title: Text("Are you sure?"), message: Text("You will delete \(game.name)"), buttons: [ .cancel(), .destructive(Text("Delete"), action: {
                    if let indexSet = gameStore.indexSet(for: game) {
                        gameStore.delete(at: indexSet)
                    }
                })
                                                                                                                  ])
            }
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}

