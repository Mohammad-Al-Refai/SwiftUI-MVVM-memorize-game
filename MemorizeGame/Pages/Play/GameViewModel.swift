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
        revealCardsFor(sec: REVEAL_CARDS_DURATION_SEC)
    }

    func newGame() {
        cards.removeAll()
        cardSelection.clear()
        initCards()
        shuffle()
        revealCardsFor(sec: REVEAL_CARDS_DURATION_SEC)
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
        if let cardIndex = cards.firstIndex(of: card) {
            if cards[cardIndex].isFaceUp {
                return
            }
            cards[cardIndex].toggle()
            if cardSelection.isFirstCardIndexBlank() {
                cardSelection.selectAsFirst(index: cardIndex)
                return
            }
            cardSelection.selectAsSecond(index: cardIndex)
        } else {
            return
        }
        if checkCardsMatch() {
            cards[cardSelection.firstCardIndex].matched()
            cards[cardSelection.secondCardIndex].matched()
            cardSelection.clear()
            increaseScore()
            if checkAreAllDone() {
                waitFor(sec: 1) {
                    self.newGame()
                }
            }
            return
        }
        canSelect = false
        waitFor(sec: 0.5) {
            self.cards[self.cardSelection.firstCardIndex].toggle()
            self.cards[self.cardSelection.secondCardIndex].toggle()
            self.cardSelection.clear()
            self.canSelect = true
        }
    }

    private func checkAreAllDone() -> Bool {
        var allMatched = true
        for card in cards {
            if !card.isMatched {
                allMatched = false
            }
        }
        return allMatched
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

    func gameTitle() -> String {
        switch gameType {
        case .Emoji:
            return "Emoji"
        case .Characters:
            return "Characters"
        case .Numbers:
            return "Numbers"
        }
    }

    func shuffle() {
        withAnimation(.default) {
            cards.shuffle()
        }
    }

    func revealCardsFor(sec: Double) {
        canSelect = false
        for cardIndex in cards.indices {
            cards[cardIndex].toggle()
        }
        waitFor(sec: sec) {
            for cardIndex in self.cards.indices {
                self.cards[cardIndex].toggle()
            }
            self.canSelect = true
        }
    }
}

struct CardSelection {
    private let empty = -1
    var firstCardIndex: Int
    var secondCardIndex: Int

    init() {
        firstCardIndex = empty
        secondCardIndex = empty
    }

    mutating func selectAsFirst(index: Int) {
        firstCardIndex = index
    }

    mutating func selectAsSecond(index: Int) {
        secondCardIndex = index
    }

    mutating func clear() {
        firstCardIndex = empty
        secondCardIndex = empty
    }

    func isFirstCardIndexBlank() -> Bool {
        return firstCardIndex == empty
    }

    func isSecondCardIndexBlank() -> Bool {
        return secondCardIndex == empty
    }
}
