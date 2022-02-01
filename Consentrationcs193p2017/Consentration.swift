//
//  Consentration.swift
//  Consentrationcs193p2017
//
//  Created by Валентина Буланова on 13.01.2022.
//

import Foundation

struct Concentration {
    
    var cards = [Card]()
    var score = 0
    private var seenCards: Set<Int> = []
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
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
            } else {
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
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
