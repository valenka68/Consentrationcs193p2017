//
//  Card.swift
//  Consentrationcs193p2017
//
//  Created by Валентина Буланова on 13.01.2022.
//

import Foundation

struct Card: Hashable

{
    
    var hashValue: Int {return identifier}
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private(set) var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
