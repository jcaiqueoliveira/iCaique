//
//  Concentration.swift
//  Concentration
//
//  Created by Caique Oliveira on 2/19/19.
//  Copyright © 2019 Caique Oliveira. All rights reserved.
//

import Foundation
class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard : Int?
    var numberOfPairsOfCard = 2
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex =  indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
        self.numberOfPairsOfCard = numberOfPairsOfCard
        shuffleCards(pairsNumber : numberOfPairsOfCard)
    }
    
    func newGame(){
        cards.removeAll()
        indexOfOneAndOnlyFaceUpCard = nil
        shuffleCards(pairsNumber: numberOfPairsOfCard)
    }
    
    private func shuffleCards(pairsNumber : Int){
        for _ in 0..<numberOfPairsOfCard{
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
}
