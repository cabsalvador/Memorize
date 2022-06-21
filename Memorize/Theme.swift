//
//  Theme.swift
//  Memorize
//
//  Created by Sal on 6/20/22.
//

import SwiftUI

struct Theme<Content> {
    let name: String
    let emojis: [Content]
    let numberOfCardsToShow: Int
    let color: String
    
    init(name: String, emojis: [Content], numberOfCardsToShow: Int, color: String) {
        self.name = name
        self.emojis = emojis
        if numberOfCardsToShow > emojis.count {
            self.numberOfCardsToShow = emojis.count
        } else {
            self.numberOfCardsToShow = numberOfCardsToShow
        }
        self.color = color
    }
}
