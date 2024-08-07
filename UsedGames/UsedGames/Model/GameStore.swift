//
//  GameStore.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import UIKit

class GameStore: ObservableObject {
  
    @Published var games: [Game] = [] 
    
    init() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveChanges),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        do {
            let data = try Data(contentsOf: gameFileURL)
            let decoder = PropertyListDecoder()
            let games = try decoder.decode([Game].self, from: data)
            
            self.games = games
        } catch {
            print(error)
        }
    }
    
    @discardableResult func createGame() -> Game {
        let game = Game(random: true)
        games.append(game)
        return game
    }
    
    func delete(at indexSet: IndexSet) {
        games.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, to newOffset: Int) {
        games.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func indexSet(for game: Game) -> IndexSet? {
        if let firstIndex = games.firstIndex(of: game) {
            return IndexSet(integer: firstIndex)
        } else {
            return nil
        }
    }
    
    func game(at indexSet: IndexSet) -> Game? {
        
        if let firstIndex = indexSet.first {
            return games[firstIndex]
        } else {
            return nil
        }
    }
    
    func update(game: Game, newValue: Game) {
        if let index = games.firstIndex(of: game) {
            games[index] = newValue
        }
    }
    
    @objc func saveChanges() {
        let encoder = PropertyListEncoder()
        do {
           let data = try encoder.encode(games)
            do {
                try data.write(to: gameFileURL)
            } catch {
                print("An error occured while saving to path: \(error.localizedDescription)")
            }
        } catch {
            print("An error occured while encoding: \(error.localizedDescription)")
        }
    }
    
    let gameFileURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("games.plist")
    }()
}
