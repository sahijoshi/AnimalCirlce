//
//  CircleButton.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 17.4.2021.
//

import UIKit

class CircleButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 50
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.white.cgColor
    }
}
