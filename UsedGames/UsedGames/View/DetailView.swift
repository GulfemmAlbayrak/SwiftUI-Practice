//
//  DetailView.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 6.08.2024.
//

import SwiftUI
import Combine

struct DetailView: View {
    
    var game: Game
    var gameStore: GameStore
    
    @State var name: String = ""
    @State var price: Double = 0.0
    
    @State var shouldEnableSaveButton: Bool = true
    
    func validate() {
        shouldEnableSaveButton = game.name != self.name || game.priceInDollars != price
    }
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Name")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onReceive(Just(name), perform: { newValue in
                            validate()
                        })
                }
                .padding(.vertical, 4.0)
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Price in Dollars")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    TextField("Price", value: $price, formatter: Formatters.dollarFormatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onReceive(Just(price), perform: { newValue in
                            validate()
                        })
                }
                .padding(.vertical, 4.0)
            }
            Section {
                Button(action: {
                    let newGame = Game(name: name, priceInDollars: price, serialNumber: game.serialNumber)
                    gameStore.update(game: game, newValue: newGame)
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50.0)
                })
                .disabled(!shouldEnableSaveButton)
            }
        }
        .toolbar {
            ToolbarItem(placement: <#T##ToolbarItemPlacement#>, content: <#T##() -> View#>)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let gameStore = GameStore()
        let game = gameStore.createGame()
        DetailView(game: game, gameStore: gameStore)
    }
}
