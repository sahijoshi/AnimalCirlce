//
//  QuizButton.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 17.4.2021.
//

import UIKit

class QuizButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orange.cgColor
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
}
