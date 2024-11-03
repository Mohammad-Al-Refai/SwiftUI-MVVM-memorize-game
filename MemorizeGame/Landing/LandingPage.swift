//
//  LandingPage.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/3/24.
//

import SwiftUI

struct LandingPage: View {
    @EnvironmentObject var appViewModel: AppViewModel
    var body: some View {
        VStack {
            Spacer()
            Text("Memorize🎈").font(.largeTitle)
            Spacer()
            LazyVGrid(columns: [GridItem()], spacing: 20) {
                AnimatedButton(text: "Emojies") {
                    appViewModel.navigateToPlay(_gameType: .Emoji)
                }

                AnimatedButton(text: "Latters") {
                    appViewModel.navigateToPlay(_gameType: .Latters)
                }

                AnimatedButton(text: "Numbers") {
                    appViewModel.navigateToPlay(_gameType: .Numbers)
                }
            }.padding()
            Spacer()
        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
