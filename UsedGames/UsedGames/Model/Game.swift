//
//  Game.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import Foundation

class Game: NSObject, Identifiable, Codable {
    var name: String
    var priceInDollars: Double
    var serialNumber: String
    var dateCreated: Date
    let itemKey: String
    
    init(name: String, priceInDollars: Double, serialNumber: String) {
        self.name = name
        self.priceInDollars = priceInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
    }
    
    convenience init(random: Bool = false) {
        if random {
            let conditions = ["New", "Mint", "Used"]
            var idx = Int.random(in: 0..<conditions.count)
            let randomCondition = conditions[idx]
            
            let names = ["Resident Evil", "Gears Of War", "Halo", "God of War"]
            idx = Int.random(in: 0..<names.count)
            let randomName = names[idx]
            
            idx = Int.random(in: 0..<6)
            
            let randomTitle = "\(randomCondition) \(randomName) \(idx)"
          
            let serialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            let priceInDollars = Double.random(in: 0...70 )
            self.init(name: randomTitle, priceInDollars: priceInDollars, serialNumber: serialNumber)
        } else {
            self.init(name: "", priceInDollars: 0, serialNumber: "")
        }
    }
}
