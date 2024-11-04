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
            VStack {
                AnimatedButton(text: "Emojies") {
                    appViewModel.navigateToPlay(_gameType: .Emoji)
                }

                AnimatedButton(text: "Characters") {
                    appViewModel.navigateToPlay(_gameType: .Characters)
                }

                AnimatedButton(text: "Numbers") {
                    appViewModel.navigateToPlay(_gameType: .Numbers)
                }
            }.padding().aspectRatio(contentMode: .fit)
            Spacer()
        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
