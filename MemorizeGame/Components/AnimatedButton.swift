//
//  AnimatedButton.swift
//  MemorizeGame
//
//  Created by Mohammad on 11/3/24.
//

import SwiftUI

struct AnimatedButton: View {
    var text: String
    var onClick: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.orange)
    
            Text(text)
                .foregroundColor(.white)
                .font(.largeTitle)
        }
        .onTapGesture {
            onClick()
        }
        .aspectRatio(contentMode: .fit)
    }
}


struct AnimatedButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedButton(text: "Play") {}
    }
}
