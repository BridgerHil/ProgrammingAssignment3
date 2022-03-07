//
//  SetGame.swift
//  SetGameApp
//
//  Created by Bridger Hildreth on 3/6/22.
//

import Foundation

struct SetGame {
    
    private(set) var currentDeck = SetCardDeck()
    private(set) var cards = [SetCard]()
    private(set) var selectedCards = [SetCard]()

    
    mutating func selectCard(_ card: SetCard) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            cards[chosenIndex].isSelected.toggle()
            if cards[chosenIndex].isSelected {
                selectedCards.append(cards[chosenIndex])
            } else   {
                for i in 0..<selectedCards.count {
                    if selectedCards[i] == cards[chosenIndex] {
                        selectedCards.remove(at: i)
                    }
                }
                
            }
        }
    }
    
    mutating func set12Cards() {
        for _ in 0...11 {
            cards.append(currentDeck.remove())
        }
    }
    
    init() {
        set12Cards()
    }
    
    mutating func add3Cards() {
        print(currentDeck.count())
        for _ in 0...2 {
            cards.append(currentDeck.remove())
        }
    }
    
    func deckCounter() -> Int {
        return currentDeck.count()
    }
    
    mutating func newGameButton() {
        cards.removeAll()
        currentDeck = SetCardDeck()
        set12Cards()
    }
    
    func setLogic() -> Bool {
        //These constants check in the first case if everything of that variable is the same
        //The second case checks if everything is different from one another
        //This is because in a set, cards can either be all the same or all different
        let shapeLogic = ((cards[0].shape == cards[1].shape && cards[1].shape == cards[2].shape) || (cards[0].shape != cards[1].shape && cards[0].shape != cards[2].shape && cards[1].shape != cards[2].shape))
        let colorLogic = ((cards[0].color == cards[1].color && cards[1].color == cards[2].color) || (cards[0].color != cards[1].color && cards[0].color != cards[2].color && cards[1].color != cards[2].color))
        let shadeLogic = ((cards[0].shade == cards[1].shade && cards[1].shade == cards[2].shade) || (cards[0].shade != cards[1].shade && cards[0].shade != cards[2].shade && cards[1].shade != cards[2].shade))
        let countLogic = ((cards[0].count == cards[1].count && cards[1].count == cards[2].count) || (cards[0].count != cards[1].count && cards[0].count != cards[2].count && cards[1].count != cards[2].count))
        
        if shapeLogic && colorLogic && shadeLogic && countLogic {
            return true
        } else {
            return false
        }
    }    
}
