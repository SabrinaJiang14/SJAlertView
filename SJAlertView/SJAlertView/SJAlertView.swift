//
//  SJAlertView.swift
//  SJAlertView
//
//  Created by Eileen on 2018/3/2.
//  Copyright © 2018年 Eileen. All rights reserved.
//

import UIKit

typealias block = () -> ()

class SJAlertView: UIViewController {

    fileprivate var viewWidth: CGFloat = 0.0
    fileprivate var viewHeight: CGFloat = 0.0
    
    fileprivate var leftButtonAction: block?
    fileprivate var rightButtonAction: block?
    
    func initialize() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String?, lblDescriptionText:String?, lblDescriptionAttrText:NSAttributedString?, imageName:String?, lButtontitle:String?, rButtonTitle:String?, lButtonColor:UIColor?, rButtonColor:UIColor?, radius: CGFloat?, leftAction lAction:block?, rightAction rAction:block?) {
        self.init()
        
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        
        let newAlert = CustomAlertView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        view.addSubview(newAlert)
        
        if let titleString = title {
            newAlert.lblTitle.text = titleString
        }else{
            if let _ = imageName {
                newAlert.lblTitle.isHidden = true
            }else{
                newAlert.lblTitle.text = " "
            }
        }
        
        if let msg = lblDescriptionText {
            newAlert.lblDescription.text = msg
        }else if let attr = lblDescriptionAttrText {
            newAlert.lblDescription.attributedText = attr
        }else{
            newAlert.lblDescription.isHidden = true
        }
        
        if let img = imageName {
            newAlert.icoImageView.image = UIImage(named: img)
            newAlert.imgHeight.constant = 48
        }else{
            newAlert.icoImageView.image = nil
            newAlert.imgHeight.constant = 10
        }
        newAlert.icoImageView.needsUpdateConstraints()
        
        if let lbTitle = lButtontitle {
            newAlert.button1.setTitle(lbTitle, for: .normal)
            newAlert.button1.accessibilityIdentifier = "btn_left"
        }else{
            fatalError("Left Button title is require!!")
        }
        
        if let rbTitle = rButtonTitle {
            newAlert.button2.setTitle(rbTitle, for: .normal)
            newAlert.button2.accessibilityIdentifier = "btn_right"
            newAlert.buttomHeight.constant = 0
        }else{
            newAlert.button2.isHidden = true
            newAlert.buttomHeight.constant = 10
        }
        newAlert.buttomLabel.needsUpdateConstraints()
        
        if let lbColor = lButtonColor {
            newAlert.button1.setTitleColor(UIColor.white, for: .normal)
            newAlert.button1.backgroundColor = lbColor
        }else{
            fatalError("Left Button need background color!!")
        }
        
        if let rbColor = rButtonColor {
            newAlert.button2.setTitleColor(UIColor.white, for: .normal)
            newAlert.button2.backgroundColor = rbColor
        }else{
            newAlert.button2.setTitleColor(lButtonColor, for: .normal)
            newAlert.button2.backgroundColor = UIColor.white
        }
        
        if let rad = radius {
            newAlert.backView.layer.cornerRadius = rad
            newAlert.backView.layer.masksToBounds = true
        }
        
        if lAction != nil {
            leftButtonAction = lAction
            newAlert.button1.addTarget(self, action: #selector(leftButtonClick), for: UIControlEvents.touchUpInside)
        }
        
        if rAction != nil {
            rightButtonAction = rAction
            newAlert.button2.addTarget(self, action: #selector(rightButtonClick), for: UIControlEvents.touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func leftButtonClick(){
        leftButtonAction!()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func rightButtonClick(){
        rightButtonAction!()
        dismiss(animated: true, completion: nil)
    }
}

extension SJAlertView:UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presented == self {
            return  CustomPresentationController(presentedViewController: presented, presenting: presenting)
        }else{
            return nil
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented == self {
            return CustomPresentationAnimationController(isPresenting: true)
        } else {
            return nil
        }
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed == self {
            return CustomPresentationAnimationController(isPresenting: false)
        } else {
            return nil
        }
    }
}
