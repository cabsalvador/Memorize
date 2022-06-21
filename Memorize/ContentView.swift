//
//  ContentView.swift
//  Memorize
//
//  Created by Sal on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.theme.name.capitalized)
                .font(.title)
            
            HStack {
                let size: CGFloat = 30
                Text("Score")
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: size, height: size)
                    .foregroundColor(viewModel.color)
                    .opacity(0.3)
                    .overlay {
                        Text("\(viewModel.score)")
                    }
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.color)
            
            Button(action: viewModel.newGame) {
                Text("New Game")
                    .font(.title2)
                    .frame(maxWidth: .infinity, maxHeight: 35)
            }
            .buttonStyle(.bordered)
            .tint(viewModel.color)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}

