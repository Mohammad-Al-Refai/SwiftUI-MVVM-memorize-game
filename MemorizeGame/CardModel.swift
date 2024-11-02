//
//  CardModel.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/2/24.
//

import Foundation

struct CardModel: Identifiable, Hashable {
    var id = UUID()
    var content: String
    var isFaceUp = false
    var isMatched = false
    mutating func toggle() {
        isFaceUp.toggle()
    }

    mutating func matched() {
        isMatched.toggle()
    }
}
