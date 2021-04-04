import UIKit

class SimpsonController: UIViewController {
    
    var networkManager = NetworkSimpsonManager()
    
    let quoteLabel: QuoteLabel = QuoteLabel()
    let nameLabel: NameLabel = NameLabel()
    let characterImageView: CharacterImageView = CharacterImageView(frame: CGRect())
    let nextCharacterButton: CharacterNextButton = CharacterNextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        nextCharacterButton.addTarget(self, action: #selector(nextCharacterButton(_:)), for: .touchUpInside)
        networkManager.onCompletion = { [weak self] character in
            guard let self = self else { return }

            self.updateCharacter(simpsonCharacter: character)
        }
        setConstraints()
    }
    
    @objc func nextCharacterButton(_ sender: UIButton) {
        self.networkManager.fetchData()
    }
    
    func updateCharacter(simpsonCharacter: CharacterToView) {
        
        guard let image = simpsonCharacter.imageCharacter,
              let urlImage = URL(string: image),
              let characterImageData = try? Data(contentsOf: urlImage) else { return }
        
        DispatchQueue.main.async {
            self.nameLabel.text = simpsonCharacter.nameCharacter
            self.quoteLabel.text = simpsonCharacter.quoteCharacter
            self.characterImageView.image = UIImage(data: characterImageData)
        }
    }
    
    func setConstraints() {
        view.addSubview(nameLabel)
        view.addSubview(quoteLabel)
        view.addSubview(characterImageView)
        view.addSubview(nextCharacterButton)

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            quoteLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant:  16),
            quoteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            quoteLabel.heightAnchor.constraint(equalToConstant: 100),
            quoteLabel.widthAnchor.constraint(equalToConstant: 200),
            
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 20),
            characterImageView.heightAnchor.constraint(equalToConstant: 300),
            characterImageView.widthAnchor.constraint(equalToConstant: 200),
            
            nextCharacterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextCharacterButton.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20),
            nextCharacterButton.heightAnchor.constraint(equalToConstant: 100),
            nextCharacterButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

