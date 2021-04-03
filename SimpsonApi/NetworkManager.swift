//
//  NetworkManager.swift
//  SimpsonApi
//
//  Created by Mikita Palyka on 3.04.21.
//

import Foundation

class NetworkSimpsonManager {
    
    var onCompletion: ((CharacterToView) -> Void)?
    
    func fetchData(){
        let urlString = "https://thesimpsonsquoteapi.glitch.me/quotes"
        guard let url = URL(string: urlString) else { return } 
       
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let character = self.parseJSON(withData: data) {
                    self.onCompletion?(character)
                    print(character)
                }
            }
        }.resume()
    }
    
    
    func parseJSON(withData data: Data) -> CharacterToView? {
        let decoder = JSONDecoder()
        
        do {
            let currentCharacterData = try decoder.decode([Character].self, from: data)[0]
            guard  let currentCharacter = CharacterToView(characterToView: currentCharacterData) else {
                return nil
            }
            return currentCharacter
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return nil
    }
}
