//
//  Consentration.swift
//  Consentrationcs193p2017
//
//  Created by Валентина Буланова on 13.01.2022.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var score = 0
    private var seenCards: Set<Int> = []
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    //cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    //score + 2
                    score += 2
                } else {
                    //cards didn't match
                    if seenCards.contains(index) {
                            score -= 1
                    }
                    if seenCards.contains(matchIndex) {
                            score -= 1
                    }
                seenCards.insert(index)
                seenCards.insert(matchIndex)
               }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil    // not one and only ...
            } else {
                // either no card or two cards face up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        for _ in 1...cards.count {
            let randomIndex = Int.random(in: 0..<cards.count)
            cards.swapAt(0, randomIndex)
        }
    }
    
}
