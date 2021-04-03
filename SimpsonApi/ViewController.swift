//
//  ViewController.swift
//  SimpsonApi
//
//  Created by Никита Полыко on 1.04.21.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    let characterImageView: UIImageView = {
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
        fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        fetchData()
        setConstraints()
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
    
    
    let url = "https://thesimpsonsquoteapi.glitch.me/quotes"

    func fetchData(){
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            print("data: \(data)")
            
            do {
                
                let result = try JSONDecoder().decode([Character].self, from: data)
                
                guard let image = result.first?.image,
                      let urlImage = URL(string: image),
                      let characterImageData = try? Data(contentsOf: urlImage) else { return }
                
                DispatchQueue.main.sync {
                    self.quoteLabel.text = result.first?.quote
                    self.nameLabel.text = result.first?.character
                    self.characterImageView.image = UIImage(data: characterImageData)
                }
                
            } catch let error {
                print("Error: \(error)")
            }
        }.resume()
    }
}

