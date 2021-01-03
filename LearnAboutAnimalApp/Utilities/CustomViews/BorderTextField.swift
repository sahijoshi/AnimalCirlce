//
//  BorderTextField.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 1.1.2021.
//

import UIKit

class BorderTextField: UITextField {

    @IBInspectable var insetX: CGFloat = 10
    @IBInspectable var insetY: CGFloat = 0
    @IBInspectable var bgColor: UIColor = UIColor.white

    var bottomLine = CALayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setBottomBorder()
    }
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor

        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.orange.cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}
