//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sal on 6/17/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var score: Int
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
        score = 0
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += calculatedScore(card1: cards[chosenIndex], card2: cards[potentialMatchIndex])
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = nil
                    score += calculatedScore(card1: cards[chosenIndex], card2: cards[potentialMatchIndex])
                    cards[chosenIndex].wasSeen = true
                    cards[potentialMatchIndex].wasSeen = true
                }
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }

        
    }
    
    mutating func calculatedScore(card1: Card, card2: Card) -> Int {
        var newScore = 0
        if card1.wasSeen {
            newScore -= 1
        }
        if card2.wasSeen {
            newScore -= 1
        }
        
        if card1.isMatched && card2.isMatched {
            newScore += 2
        }
        return newScore
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var wasSeen: Bool = false
        var content: CardContent
        let id: Int
    }
}
