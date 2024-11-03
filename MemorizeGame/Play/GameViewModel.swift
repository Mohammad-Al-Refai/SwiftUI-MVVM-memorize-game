//
//  GameViewModel.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/2/24.
//

import Foundation
import SwiftUI



final class GameViewModel: ObservableObject {
    var gameType: GameType
    @Published var score = 0
    @Published var cards: [CardModel] = []
    private var canSelect = false
    private var cardSelection = CardSelection()

    init(_gameType: GameType) {
        gameType = _gameType
        initGame()
    }

    func initGame() {
        cards.removeAll()
        cardSelection.clear()
        initCards()
        score = 0
        shuffle()
        revealCardsFor(deadline: .now() + 3)
    }

    private func checkCardsMatch() -> Bool {
        let firstCard = cards[cardSelection.firstCardIndex]
        let secondCard = cards[cardSelection.secondCardIndex]
        return firstCard.content == secondCard.content
    }

    func select(card: CardModel) {
        if !canSelect {
            return
        }
        let cardIndex = cards.firstIndex(of: card)
        if cardIndex == nil {
            return
        }
        if cards[cardIndex!].isFaceUp {
            return
        }
        cards[cardIndex!].toggle()
        if cardSelection.isFirstCardIndexBlank() {
            cardSelection.selectAsFirst(index: cardIndex!)
            return
        }
        cardSelection.selectAsSecond(index: cardIndex!)
        if checkCardsMatch() {
            cards[cardSelection.firstCardIndex].matched()
            cards[cardSelection.secondCardIndex].matched()
            cardSelection.clear()
            increaseScore()
        } else {
            canSelect = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cards[self.cardSelection.firstCardIndex].toggle()
                self.cards[self.cardSelection.secondCardIndex].toggle()
                self.cardSelection.clear()
                self.canSelect = true
            }
        }
    }

    private func increaseScore() {
        score += MATCH_SCORE_POINTS
    }

    private func initCards() {
        switch gameType {
        case .Emoji:
            for emoji in EMOJIS {
                cards.append(CardModel(content: emoji))
            }
        case .Characters:
            for latter in CHARACTERS {
                cards.append(CardModel(content: latter))
            }
        case .Numbers:
            for number in NUMBERS {
                cards.append(CardModel(content: number))
            }
        }
    }

    func shuffle() {
        withAnimation(.default) {
            cards.shuffle()
        }
    }

    func revealCardsFor(deadline: DispatchTime) {
        canSelect = false
        for cardIndex in cards.indices {
            cards[cardIndex].toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            for cardIndex in self.cards.indices {
                self.cards[cardIndex].toggle()
            }
            self.canSelect = true
        }
    }
}

struct CardSelection {
    var firstCardIndex: Int = -1
    var secondCardIndex: Int = -1

    mutating func selectAsFirst(index: Int) {
        firstCardIndex = index
    }

    mutating func selectAsSecond(index: Int) {
        secondCardIndex = index
    }

    mutating func clear() {
        firstCardIndex = -1
        secondCardIndex = -1
    }

    func isFirstCardIndexBlank() -> Bool {
        return firstCardIndex == -1
    }

    func isSecondCardIndexBlank() -> Bool {
        return secondCardIndex == -1
    }
}
