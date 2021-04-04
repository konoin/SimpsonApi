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
            let characters = try decoder.decode([Character].self, from: data)
            guard let firstCharacter = characters.first else { return nil }
            guard  let currentCharacter = CharacterToView(characterToView: firstCharacter) else {
                return nil
            }
            return currentCharacter
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return nil
    }
}
