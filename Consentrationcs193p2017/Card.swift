//
//  Card.swift
//  Consentrationcs193p2017
//
//  Created by Валентина Буланова on 13.01.2022.
//

import Foundation

struct Card {
    
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
