import Foundation
import UIKit

class QuoteLabel: UILabel {
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
        self.text = ""
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 13)
        self.numberOfLines = 0
    }
}
