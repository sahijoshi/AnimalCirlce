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
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
//        bottomLine.backgroundColor = UIColor(red: 100, green: 100, blue: 100).cgColor
        bottomLine.backgroundColor = UIColor.white.cgColor


        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
//        self.layer.backgroundColor = bgColor.cgColor

//        self.layer.cornerRadius = 2
//        self.layer.borderWidth = 1
//        self.layer.borderColor =
////        self.layer.masksToBounds = false
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}
