//
//  InfoDetail.swift
//  AugmentedCard
//
//  Created by skj on 5.4.2021.
//  Copyright © 2021 Prayash Thapa. All rights reserved.
//

import UIKit

class InfoBrief: UIView {
    @IBOutlet weak var txtBriefInfo: UITextView!
    @IBOutlet weak var lblTitle: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadView() -> InfoBrief {
        let customInfoWindow = Bundle.main.loadNibNamed("InfoBrief", owner: self, options: nil)?[0] as! InfoBrief
        customInfoWindow.layer.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1).cgColor
//        customInfoWindow.layer.cornerRadius = 4
//        customInfoWindow.imagePlace.layer.cornerRadius = 4
        return customInfoWindow
    }
}
