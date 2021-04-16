//
//  InfoDetail.swift
//  AugmentedCard
//
//  Created by skj on 5.4.2021.
//  Copyright © 2021 Prayash Thapa. All rights reserved.
//

import UIKit

class InfoDetail: UIView {
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnClassification: UIButton!
    @IBOutlet weak var btnLife: UIButton!
    @IBOutlet weak var btnHeight: UIButton!
    @IBOutlet weak var btnWeight: UIButton!
    @IBOutlet weak var btnHabitat: UIButton!
    @IBOutlet weak var txtStatus: UITextView!
    @IBOutlet weak var txtClassification: UITextView!
    @IBOutlet weak var txtLife: UITextView!
    @IBOutlet weak var txtHeight: UITextView!
    @IBOutlet weak var txtWeight: UITextView!
    @IBOutlet weak var txtHabitat: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadView() -> InfoDetail {
        let customInfoWindow = Bundle.main.loadNibNamed("InfoDetail", owner: self, options: nil)?[0] as! InfoDetail
        customInfoWindow.layer.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
//        customInfoWindow.layer.cornerRadius = 4
//        customInfoWindow.imagePlace.layer.cornerRadius = 4
        return customInfoWindow
    }
}
