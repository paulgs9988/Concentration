//
//  ViewController.swift
//  Concentration
//
//  Created by Paul Sullivan on 8/30/20.
//  Copyright © 2020 Paul Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        get{
            return(cardButtons.count+1)/2
        }
    }
    private(set) var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"

        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("chosen card not found in cardButtons")
        }
    }
   
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0): #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
   
    private var emojiChoices = ["🎃","👻","😈","⏣","👽","👁","🐶","🐼","🐣"]
    //could also use this syntax: [Int:String]() for dictionary
    private var emoji = Dictionary<Int, String>()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil{
            if emojiChoices.count>0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        //****could use this syntax for below if/else statement:
        //return emoji[card.identifier] ?? "?" ****
        
        if emoji[card.identifier] != nil{
            return emoji[card.identifier]!
        }else{
            return "?"
        }
    }
   
}

