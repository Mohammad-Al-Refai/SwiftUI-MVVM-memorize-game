//
//  ContentView.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/2/24.
//

import SwiftUI

struct PlayPage: View {
    @StateObject var vm: GameViewModel

    var body: some View {
        VStack {
            cards
            Spacer()
            footer
        }.padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 0) {
            ForEach(vm.cards, id: \.id) { card in
                CardView(card: card) {
                    vm.select(card: card)
                }.animation(.easeInOut(duration: 0.2), value: vm.cards)
            }
        }
    }

    @State var scoreScale: CGFloat = 1.0
    var footer: some View {
        HStack {
            Button("New Game") {
                vm.initGame()
            }
            Spacer()
            Text("Score: \(vm.score)")
                .font(.title)
                .scaleEffect(scoreScale)
                .onChange(of: vm.score) { _ in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        scoreScale = 1.5
                    }
                    withAnimation(.easeInOut(duration: 0.2).delay(0.2)) {
                        scoreScale = 1.0
                    }
                }
            Spacer()
            Button("Shuffle") {
                withAnimation(.easeInOut(duration: 1)) {
                    vm.shuffle()
                }
            }
        }.padding()
    }
}

struct CardView: View {
    var card: CardModel
    var onClick: () -> Void
    var body: some View {
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: 12)
            base.stroke(lineWidth: 3)
            Text(card.content).font(.largeTitle)
            base.opacity(card.isFaceUp ? 0 : 1)
        }
        .foregroundColor(.orange)
        .disabled(card.isMatched)
        .aspectRatio(1 / 1, contentMode: .fill)
        .transition(.opacity.animation(.easeInOut(duration: 0.5)))
        .opacity(card.isMatched ? 0 : 1)
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        .onTapGesture {
            onClick()
        }
    }
}


 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPage(vm: GameViewModel(_gameType:.Numbers))
    }
 }
