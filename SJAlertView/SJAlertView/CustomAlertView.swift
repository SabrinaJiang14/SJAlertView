//
//  CustomAlertView.swift
//  hoods
//
//  Created by Sabrina on 2018/5/3.
//  Copyright © 2018年 zephyr. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {

    @IBOutlet weak var icoImageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var buttomHeight: NSLayoutConstraint!
    @IBOutlet weak var buttomLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialView()
    }
    
    private func initialView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomAlertView", bundle: bundle)
        if let customView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            customView.backgroundColor = UIColor.clear
            addSubview(customView)
        }
    }

}
