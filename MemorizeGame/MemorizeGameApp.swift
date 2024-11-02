//
//  MemorizeGameApp.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/2/24.
//

import SwiftUI

@main
struct MemorizeGameApp: App {
    let vm = GameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(vm: vm)
        }
    }
}
