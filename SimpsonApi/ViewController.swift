//
//  ViewController.swift
//  SimpsonApi
//
//  Created by Никита Полыко on 1.04.21.
//

import UIKit

class ViewController: UIViewController {
    
    var networkManager = NetworkSimpsonManager()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    var characterImageView: UIImageView = {
        let characterImage = UIImageView()
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        return characterImage
    }()
    
    let nextCharacterButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextCharacterButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Press Me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 16
        return button
    }()
    
    @objc func nextCharacterButton(_ sender: UIButton) {
        self.networkManager.fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        networkManager.onCompletion = { [weak self] character in
            guard let self = self else { return }

            self.updateCharacter(simpsonCharacter: character)
        }
        setConstraints()
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

