//
//  ViewController.swift
//  Concentration
//
//  Created by Caique Oliveira on 2/13/19.
//  Copyright © 2019 Caique Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count + 1 ) / 2)
   let emojis = ["🎃","👌","👻", "🦇", "😈", "🍭", "🍬", "🍎", "🙀","❤️"]
   lazy var emojiChoices = emojis
    
   var emoji = [Int : String]()
   
   var flipCount = 0 {
        didSet{
             flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
       flipCount+=1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9704427123, green: 0.9998367429, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        flipCount = 0
        emoji.removeAll()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        emojiChoices = emojis
    }
    
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}
