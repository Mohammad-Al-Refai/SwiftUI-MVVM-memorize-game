//
//  AppViewModel.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/3/24.
//

import Foundation
import SwiftUI

enum Distinations {
    case Landing
    case Play
}

class AppViewModel: ObservableObject {
    @Published var distination: Distinations = .Landing
    @Published var gameType: GameType = .Emoji
    func navigateToPlay(_gameType: GameType) {
        gameType = _gameType
        distination = Distinations.Play
    }
    func navigateToLanding() {
        distination = Distinations.Landing
    }
}
