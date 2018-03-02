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

    fileprivate var alertTitle: String?
    fileprivate var alertMessage: String?
    fileprivate var leftButtonTitle: String?
    fileprivate var rightButtonTitle: String?
    fileprivate var leftButtonColor: UIColor = UIColor.white
    fileprivate var rightButtonColor: UIColor = UIColor.white
    fileprivate var cornerRadius: CGFloat = 0.0
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
    
    func setView(title: String?, mssage:String?, lButtontitle:String?, rButtonTitle:String?, lButtonColor:UIColor?, rButtonColor:UIColor?, radius: CGFloat?, leftAction lAction:block?, rightAction rAction:block?) {

        if let titleString = title {
            self.alertTitle = titleString
        }
        
        if let msg = mssage {
            self.alertMessage = msg
        }
        
        if let lbTitle = lButtontitle {
            self.leftButtonTitle = lbTitle
        }
        
        if let rbTitle = rButtonTitle {
            self.rightButtonTitle = rbTitle
        }
        
        if let lbColor = lButtonColor {
            self.leftButtonColor = lbColor
        }
        
        if let rbColor = rButtonColor {
            self.rightButtonColor = rbColor
        }
        
        if let rad = radius {
            self.cornerRadius = rad
        }
        
        if lAction != nil {
            leftButtonAction = lAction
        }
        
        if rAction != nil {
            rightButtonAction = rAction
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        
        //Step 1
        drawBackView()
        //Step 2
        drawTitle()
        //Step 3
        drawMassage()
        //Step 4
        drawLeftButton()
        //Step 5
        drawRightButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawBackView(){
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = self.cornerRadius
        backView.layer.masksToBounds = true
        self.view.addSubview(backView)
    }
    
    func drawTitle(){
        let leftPadding: CGFloat = 20
        let topPadding: CGFloat = 10
        
        let lblTitle = UILabel(frame: CGRect(x: leftPadding, y: topPadding, width: viewWidth - (leftPadding * 2), height: 40))
        lblTitle.textAlignment = .center
        lblTitle.text = self.alertTitle
        lblTitle.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(lblTitle)
    }
    
    func drawMassage(){
        let leftPadding: CGFloat = 20
        let topPadding: CGFloat = 50 // lblTitle.orgin.y + lblTitle.frame.height
        
        let lblMassage = UILabel(frame: CGRect(x: leftPadding, y: topPadding, width: viewWidth - (leftPadding * 2), height: (viewHeight / 7) * 4))
        lblMassage.textAlignment = .center
        lblMassage.text = self.alertTitle
        lblMassage.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(lblMassage)
    }
    
    func drawLeftButton(){
        let leftPadding: CGFloat = 20
        let topPadding: CGFloat = 50 + ((viewHeight / 7) * 4) // lblMassage.orgin.y + lblMassage.frame.height
        
        let leftButton = UIButton(frame: CGRect(x: leftPadding, y: topPadding, width: ((viewWidth - (leftPadding * 2)) / 2), height: 40))
        leftButton.addTarget(self, action: #selector(leftButtonClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(leftButton)
        
        if let tit = self.leftButtonTitle {
            leftButton.setTitle(tit, for: UIControlState.normal)
        }
        
        leftButton.backgroundColor = self.leftButtonColor
        leftButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        if self.leftButtonColor == UIColor.white {
            leftButton.layer.borderWidth = 0.5
            leftButton.layer.borderColor = UIColor.black.cgColor
            
            if self.rightButtonColor != UIColor.white {
                leftButton.layer.borderColor = self.rightButtonColor.cgColor
            }
        }
    }
    
    func drawRightButton(){
        let leftPadding: CGFloat = 20 + ((viewWidth - (20 * 2)) / 2)
        let topPadding: CGFloat = 50 + ((viewHeight / 7) * 4) // lblMassage.orgin.y + lblMassage.frame.height
        
        let rightButton = UIButton(frame: CGRect(x: leftPadding, y: topPadding, width: ((viewWidth - (20 * 2)) / 2), height: 40))
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(rightButton)
        
        if let tit = self.rightButtonTitle {
            rightButton.setTitle(tit, for: UIControlState.normal)
        }
        
        rightButton.backgroundColor = self.rightButtonColor
        rightButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        if self.rightButtonColor == UIColor.white {
            rightButton.layer.borderWidth = 0.5
            rightButton.layer.borderColor = UIColor.black.cgColor
            
            if self.leftButtonColor != UIColor.white {
                rightButton.layer.borderColor = self.leftButtonColor.cgColor
            }
        }
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
