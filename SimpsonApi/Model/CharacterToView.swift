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
