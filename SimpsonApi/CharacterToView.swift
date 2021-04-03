//
//  CharacterToView.swift
//  SimpsonApi
//
//  Created by Mikita Palyka on 3.04.21.
//

import Foundation

struct CharacterToView {
    let nameCharacter: String
    let quoteCharacter: String
    let imageCharacter: String?
    
    init?(characterToView: Character) {
        nameCharacter = characterToView.character
        quoteCharacter = characterToView.quote
        imageCharacter = characterToView.image
    }
}
