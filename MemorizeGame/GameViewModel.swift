//
//  GameViewModel.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/2/24.
//

import Foundation
import SwiftUI

let All_EMOJIES = ["😁", "😁", "🤕", "🤕", "😵‍💫", "😵‍💫", "😎", "😎", "🥶", "🥶", "😍", "😍", "🎃", "🎃", "🤡", "🤡"]

class GameViewModel: ObservableObject {
    let MATCH_SCORE_POINTS = 50
    @Published var score = 0
    @Published var cards: [CardModel] = []
    var cardSelection = CardSelection()

    init() {
        initGame()
    }

    func initGame() {
        cards.removeAll()
        cardSelection.clear()
        score = 0
        for emojy in All_EMOJIES {
            cards.append(CardModel(content: emojy))
        }
        shuffle()
    }

    private func checkCardsMatch() -> Bool {
        let firstCard = cards[cardSelection.firstCardIndex]
        let secondCard = cards[cardSelection.secondCardIndex]
        return firstCard.content == secondCard.content
    }

    func select(card: CardModel) {
        let cardIndex = cards.firstIndex(of: card)
        if cardIndex == nil {
            return
        }
        if cards[cardIndex!].isFaceUp{
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
            cards[cardSelection.firstCardIndex].toggle()
            cards[cardSelection.secondCardIndex].toggle()
            cardSelection.clear()
        }
    }

    private func increaseScore() {
        score += MATCH_SCORE_POINTS
    }

    func shuffle() {
        withAnimation(.easeOut(duration: 20)) {
            cards.shuffle()
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
