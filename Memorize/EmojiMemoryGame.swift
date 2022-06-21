//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sal on 6/17/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let themes = [
        Theme(name: "People", emojis: ["😀", "😅", "🤣", "😍", "😝", "🤓", "🥸", "🥳", "😏", "☹️", "😩", "🥺", "😭", "😤", "🤬", "🤯", "😳", "🥵", "🥶", "😶‍🌫️", "🫡"], numberOfCardsToShow: 10, color: "green"),
        Theme(name: "Tech", emojis: ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🕹", "💽", "📼", "📷", "🎥", "☎️", "📺", "📻", "📡", "🔌", "🎙", "🧭"], numberOfCardsToShow: 8, color: "orange"),
        Theme(name: "Activities", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏏", "🥅", "🏹", "🛝", "🥊", "🥌", "🎿"], numberOfCardsToShow: 12, color: "indigo"),
        Theme(name: "Animals", emojis: ["🐶", "🐭", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🐮", "🐷", "🐸", "🐵"], numberOfCardsToShow: 10, color: "purple"),
        Theme(name: "Food", emojis: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🍅", "🍆", "🥦", "🥬", "🥒", "🌶", "🫑", "🌽", "🥕"], numberOfCardsToShow: 14, color: "blue"),
        Theme(name: "Travel", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🛻", "🚚", "🚲", "🛵", "✈️", "🚀"], numberOfCardsToShow: 6, color: "cyan")
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
