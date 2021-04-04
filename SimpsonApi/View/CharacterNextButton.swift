import Foundation
import UIKit

class CharacterNextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("Press Me", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 16
    }
    
}
