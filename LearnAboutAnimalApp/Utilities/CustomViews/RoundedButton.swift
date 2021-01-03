//
//  RoundedButton.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 1.1.2021.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orange.cgColor
    }
}
