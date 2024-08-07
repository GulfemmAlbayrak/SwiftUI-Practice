//
//  ContentView.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var gameStore = GameStore()
    @ObservedObject var imageStore = ImageStore()
    
    @State var gameToDelete: Game?
    
    var body: some View {
        
        let  list = List {
                ForEach(gameStore.games) { (game) in
                    NavigationLink(
                        destination: DetailView(
                            game: game,
                            gameStore: gameStore,
                            imageStore: imageStore,
                            name: game.name,
                            price: game.priceInDollars,
                            selectedPhoto: imageStore.image(forKey: game.itemKey)
                        )
                        ) {
                            GameListItem(game: game)
                    }
                }
                .onDelete(perform: { indexSet in
                    let gameToDelete = gameStore.game(at: indexSet)
                    self.gameToDelete = gameToDelete
                    if let gameToDelete {
                        self.imageStore.deleteImage(forKey: gameToDelete.itemKey)
                    }
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
        if #available(iOS 16.0, *) {
            NavigationStack {
                list
            }
            .accentColor(.purple)
        } else {
            NavigationView {
                list
            }
            .accentColor(.purple)
        }
    }
}

#Preview {
    ContentView()
}

