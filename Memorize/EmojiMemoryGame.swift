//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sal on 6/17/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let themes = [
        Theme(name: "People", emojis: ["đ", "đ", "đ¤Ŗ", "đ", "đ", "đ¤", "đĨ¸", "đĨŗ", "đ", "âšī¸", "đŠ", "đĨē", "đ­", "đ¤", "đ¤Ŧ", "đ¤¯", "đŗ", "đĨĩ", "đĨļ", "đļâđĢī¸", "đĢĄ"], numberOfCardsToShow: 10, color: "green"),
        Theme(name: "Tech", emojis: ["âī¸", "đą", "đģ", "â¨ī¸", "đĨ", "đ¨", "đą", "đš", "đŊ", "đŧ", "đˇ", "đĨ", "âī¸", "đē", "đģ", "đĄ", "đ", "đ", "đ§­"], numberOfCardsToShow: 8, color: "orange"),
        Theme(name: "Activities", emojis: ["âŊī¸", "đ", "đ", "âžī¸", "đĨ", "đ", "đ", "đĨ", "đą", "đĒ", "đ", "đ¸", "đ", "đĨ", "đš", "đ", "đĨ", "đĨ", "đŋ"], numberOfCardsToShow: 12, color: "indigo"),
        Theme(name: "Animals", emojis: ["đļ", "đ­", "đą", "đš", "đ°", "đĻ", "đģ", "đŧ", "đ¨", "đ¯", "đŽ", "đˇ", "đ¸", "đĩ"], numberOfCardsToShow: 10, color: "purple"),
        Theme(name: "Food", emojis: ["đ", "đ", "đ", "đ", "đ", "đ", "đ", "đ", "đĢ", "đ", "đ", "đ", "đĨ­", "đ", "đ", "đ", "đĨĻ", "đĨŦ", "đĨ", "đļ", "đĢ", "đŊ", "đĨ"], numberOfCardsToShow: 14, color: "blue"),
        Theme(name: "Travel", emojis: ["đ", "đ", "đ", "đ", "đ", "đ", "đ", "đ", "đ", "đģ", "đ", "đ˛", "đĩ", "âī¸", "đ"], numberOfCardsToShow: 6, color: "cyan")
    ]
    
    static func createMemoryGame(theme: Theme<String>) -> MemoryGame<String> {
        let content = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCardsToShow) { pairIndex in
            content[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    @Published var theme: Theme<String>

    init() {
        let initialTheme = EmojiMemoryGame.themes[0]
        self.theme = initialTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: initialTheme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var color: Color {
        switch theme.color {
        case "green": return .green
        case "orange": return .orange
        case "indigo": return .indigo
        case "purple": return .purple
        case "blue": return .blue
        case "cyan": return .cyan
        default : return .primary
        }
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let initialTheme = EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        self.theme = initialTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: initialTheme)

    }
    
}
