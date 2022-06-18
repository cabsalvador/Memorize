//
//  ContentView.swift
//  Memorize
//
//  Created by Sal on 6/16/22.
//

import SwiftUI

struct ContentView: View {

    private let emojis = [
        ["🏎", "🚐", "🚛", "🛵", "🚚", "🚎", "🚁", "🛶", "⛴", "✈️", "🚀"],
        ["😀", "😅", "🤣", "😍", "😝", "🤓", "🥸", "🥳", "😏", "☹️", "😩", "🥺", "😭", "😤", "🤬", "🤯", "😳", "🥵", "🥶", "😶‍🌫️", "🫡"],
        ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🕹", "💽", "💾", "📼", "📷", "🎥", "📺", "📡"]
    ]
    
    @State var emojiCount = 11
    @State private  var theme = Theme.vehicles
    
    var body: some View {
        VStack {
            Text("Memorize")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(emojis[theme.value][0..<emojiCount].shuffled(), id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            HStack(spacing: 50) {
                ForEach(Theme.allCases, id: \.self) { theme in
                    Button {
                        self.theme = theme
                        emojiCount = Int.random(in: 0..<emojis[theme.value].count - 1)
                    } label: {
                        VStack {
                            Image(systemName: theme.sfSymbol)
                            Text(theme.name)
                                .font(.caption)
                        }
                    }
                }
            }
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    private enum Theme: String, CaseIterable {
        case vehicles
        case faces
        case tech
        
        var name: String {
            self.rawValue.capitalized
        }
        
        var value: Int {
            switch self {
            case .vehicles:
                return 0
            case .faces:
                return 1
            case .tech:
                return 2
            }
        }
        
        var sfSymbol: String {
            switch self {
            case .vehicles:
                return "car.fill"
            case .faces:
                return "face.smiling.fill"
            case .tech:
                return "iphone"
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

