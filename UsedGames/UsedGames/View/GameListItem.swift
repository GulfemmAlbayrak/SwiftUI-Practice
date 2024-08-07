//
//  GameListItem.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 6.08.2024.
//

import SwiftUI

struct GameListItem: View {
    var game: Game
    var numberFormatter: NumberFormatter = Formatters.dollarFormatter
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 6.0){
                Text(game.name)
                    .font(.body)
                Text(game.serialNumber)
                    .font(.caption)
                    .foregroundStyle(Color(white: 0.65))
            }
            Spacer()
            Text(NSNumber(value: game.priceInDollars), formatter: numberFormatter)
                .font(.title2)
                .foregroundStyle(game.priceInDollars > 30 ? .blue : .gray)
                .animation(nil)
        }
        .padding(.vertical, 4)
    }
}

struct GameListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameListItem(game: Game(random: true))
                .padding(.horizontal)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Light Mode")

            GameListItem(game: Game(random: true))
                .padding(.horizontal)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
