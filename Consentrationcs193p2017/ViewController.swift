//
//  ViewController.swift
//  Consentrationcs193p2017
//
//  Created by Валентина Буланова on 13.01.2022.
//

import UIKit

class ViewController: UIViewController {
    var emojiChoices = [String]()
    var emoji = [Int: String]()
    var emojiThemes = [
        1: ["🐕‍🦺", "🐓", "🐈", "🐈‍⬛", "🐏", "🐂", "🐄"],
        2: ["🐊", "🦭", "🦈", "🐳", "🦀", "🦞", "🐡"],
        3: ["🦜", "🦢", "🕊", "🦤", "🦚", "🦩", "🦃"],
        4: ["🐲", "🌿", "🌵", "🌲", "🌳", "🌴", "🪴"],
        5: ["🥝", "🍋", "🍒", "🍊", "🥦", "🌶", "🥥"],
        6: ["🍩", "🍫", "🍯", "🍦", "🍡", "🍧", "🍰"]
    ]
    private var themeIndex = 0 {
        didSet {
            emojiChoices = emojiThemes[keys[themeIndex]] ?? []
            emoji = [Int: String]()
        }
    }
    private var keys: [Int] {return Array(emojiThemes.keys)}
    @IBAction func cardButton(_ sender: UIButton) {
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        flipCount = 0
        themeIndex = Int.random(in: 0..<keys.count)
        newGame()
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!

    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
      @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }

    
    func newGame() {
        game.score = 0
        flipCount = 0
        for index in game.cards.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        themeIndex = Int.random(in: 0..<keys.count)
        // Do any additional setup after loading the view.
    }


}

