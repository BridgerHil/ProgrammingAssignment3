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
    private(set) var indexArray = [Int]()
    
    mutating func selectCard(_ card: SetCard) {
        

        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if cards[chosenIndex].isMatched {
                return
            }
            cards[chosenIndex].isSelected.toggle()
            if cards[chosenIndex].isSelected {
                selectedCards.append(cards[chosenIndex])
                indexArray.append(chosenIndex)
            } else   {
                for i in 0..<selectedCards.count-1 {
                    if selectedCards[i] == cards[chosenIndex] {
                        selectedCards.remove(at: i)
                        indexArray.remove(at: i)
                    }
                }
            }
        }
        if selectedCards.count == 3 {
            if setLogic() {
                for i in 0..<indexArray.count {
                    cards[indexArray[i]].isMatched = true
                    cards[indexArray[i]].isSelected = false
                }
            } else {
                for i in 0..<indexArray.count {
                    cards[indexArray[i]].isMisMatched = true
                    cards[indexArray[i]].isSelected = false
                }
            }
            selectedCards.removeAll()
            indexArray.removeAll()
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
        if currentDeck.count() > 0 {
            var flip = true
            for i in 0...cards.count-1 {
                if cards[i].isMatched {
                    cards[i] = currentDeck.remove()
                    flip = false
                
                }
            }
        
            if flip {
                for _ in 0...2 {
                    cards.append(currentDeck.remove())
                }
            }
        } else {
            
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
        let shapeLogic = ((selectedCards[0].shape == selectedCards[1].shape && selectedCards[1].shape == selectedCards[2].shape) || (selectedCards[0].shape != selectedCards[1].shape && selectedCards[0].shape != selectedCards[2].shape && selectedCards[1].shape != selectedCards[2].shape))
        let colorLogic = ((selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color) || (selectedCards[0].color != selectedCards[1].color && selectedCards[0].color != selectedCards[2].color && selectedCards[1].color != selectedCards[2].color))
        let shadeLogic = ((selectedCards[0].shade == selectedCards[1].shade && selectedCards[1].shade == selectedCards[2].shade) || (selectedCards[0].shade != selectedCards[1].shade && selectedCards[0].shade != selectedCards[2].shade && selectedCards[1].shade != selectedCards[2].shade))
        let countLogic = ((selectedCards[0].count == selectedCards[1].count && selectedCards[1].count == selectedCards[2].count) || (selectedCards[0].count != selectedCards[1].count && selectedCards[0].count != selectedCards[2].count && selectedCards[1].count != selectedCards[2].count))
        
        if shapeLogic && colorLogic && shadeLogic && countLogic {
            return true
        } else {
            return false
        }
    }    
}
