//
//  MemorizeGameApp.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/2/24.
//

import SwiftUI

@main
struct MemorizeGameApp: App {
    @StateObject var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
                ZStack {
                    switch appViewModel.distination {
                    case .Landing:
                        LandingPage().environmentObject(appViewModel)
                            .transition(.scale)
                    case .Play:
                        PlayPage(vm: GameViewModel(_gameType: appViewModel.gameType)).environmentObject(appViewModel)
                            .transition(.scale)
                    }
                }
                .animation(.easeInOut(duration: 0.5), value: appViewModel.distination)
        }
    }
}
