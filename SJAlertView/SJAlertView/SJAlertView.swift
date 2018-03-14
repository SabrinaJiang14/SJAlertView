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

    static let titleFontSize: CGFloat = 22
    static let messageFontSize: CGFloat = 16
    
    fileprivate var alertTitle: String?
    fileprivate var alertMessage: String?
    fileprivate var imgName: String?
    fileprivate var leftButtonTitle: String?
    fileprivate var rightButtonTitle: String?
    fileprivate var leftButtonColor: UIColor = UIColor.white
    fileprivate var rightButtonColor: UIColor = UIColor.white
    fileprivate var cornerRadius: CGFloat = 0.0
    fileprivate var viewWidth: CGFloat = 0.0
    fileprivate var viewHeight: CGFloat = 0.0
    fileprivate var backViewHeight: CGFloat = 0.0
    fileprivate var postionY: CGFloat = 0.0
    
    fileprivate var titleHeight: CGFloat = 0.0
    fileprivate var imageHeight: CGFloat = 0.0
    fileprivate var buttonHeight: CGFloat = 0.0
    
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
    
    func setView(title: String?, mssage:String?, imageName:String?, lButtontitle:String?, rButtonTitle:String?, lButtonColor:UIColor?, rButtonColor:UIColor?, radius: CGFloat?, leftAction lAction:block?, rightAction rAction:block?) {
        
        if let titleString = title {
            self.alertTitle = titleString
            titleHeight = 40
        }
        
        if let msg = mssage {
            self.alertMessage = msg
        }
        
        
        if let img = imageName {
            self.imgName = img
            imageHeight = 50
        }
        
        if let lbTitle = lButtontitle {
            self.leftButtonTitle = lbTitle
            buttonHeight = 40
        }else{
            fatalError("Left Button title is require!!")
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
        calculateBackViewHeight()
        //Step 2
        drawBackView()
        //Step 3
        drawImage()
        //Step 4
        drawTitle()
        //Step 5
        drawMassage()
        //Step 6
        drawLeftButton()
        //Step 7
        drawRightButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateBackViewHeight(){
        if let text = self.alertMessage {
            let constraint = CGSize(width: viewWidth - 40, height: viewHeight)
            let attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: SJAlertView.messageFontSize)])
            let rect: CGRect = attributedText.boundingRect(with: constraint, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            let size = rect.size
            
            if size.height < (UIScreen.main.bounds.size.height - CustomPresentationController.viewNeedAddPadding) {
                let totalHeight = titleHeight + imageHeight + buttonHeight
                backViewHeight = size.height + totalHeight + 60
                viewHeight = size.height
            }else{
                backViewHeight = (UIScreen.main.bounds.size.height - CustomPresentationController.viewNeedAddPadding)
            }
        }
    }
    
    func drawBackView(){
        let backView = UIView(frame: CGRect(x: 0, y: (self.view.frame.size.height - backViewHeight) / 2, width: viewWidth, height: backViewHeight))
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = self.cornerRadius
        backView.layer.masksToBounds = true
        self.view.addSubview(backView)
        
        postionY = backView.frame.origin.y
    }
    
    func drawImage(){
        if let img = imgName {
            let topPadding: CGFloat = 10
            
            let imgIcon = UIImageView(image: UIImage(named: img))
            imgIcon.frame = CGRect(x: (viewWidth - imageHeight) / 2, y: postionY + topPadding, width: imageHeight, height: imageHeight)
            imgIcon.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(imgIcon)
            
            postionY += (topPadding + imgIcon.frame.size.height)
        }
    }
    
    func drawTitle(){
        if let title = alertTitle {
            let leftPadding: CGFloat = 20
            let topPadding: CGFloat = 10
            
            let lblTitle = UILabel(frame: CGRect(x: leftPadding, y: topPadding + postionY, width: viewWidth - (leftPadding * 2), height: titleHeight))
            lblTitle.textAlignment = .center
            lblTitle.text = title
            lblTitle.font = UIFont.boldSystemFont(ofSize: SJAlertView.titleFontSize)
            self.view.addSubview(lblTitle)
            
            postionY += (topPadding + lblTitle.frame.size.height)
        }
    }
    
    func drawMassage(){
        if let msg = alertMessage {
            let leftPadding: CGFloat = 20
            let topPadding: CGFloat = 10
            
            let lblMassage = UILabel(frame: CGRect(x: leftPadding, y: postionY + topPadding, width: viewWidth - (leftPadding * 2), height: viewHeight))
            lblMassage.textAlignment = .center
            lblMassage.text = msg
            lblMassage.numberOfLines = 0
            lblMassage.font = UIFont.systemFont(ofSize: SJAlertView.messageFontSize)
            self.view.addSubview(lblMassage)
            
            postionY += (topPadding + lblMassage.frame.size.height)
        }
    }
    
    func drawLeftButton(){
        let leftPadding: CGFloat = 20
        
        var buttonAmount: CGFloat = 1
        if let _ = rightButtonTitle {
            buttonAmount = 2
        }
        
        let leftButton = UIButton(frame: CGRect(x: leftPadding, y: postionY + 15, width: ((viewWidth - (leftPadding * 2)) / buttonAmount), height: buttonHeight))
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
        if let tit = self.rightButtonTitle {

            let leftPadding: CGFloat = 20 + ((viewWidth - (20 * 2)) / 2)
            
            let rightButton = UIButton(frame: CGRect(x: leftPadding, y: postionY + 15, width: ((viewWidth - (20 * 2)) / 2), height: buttonHeight))
            rightButton.addTarget(self, action: #selector(rightButtonClick), for: UIControlEvents.touchUpInside)
            self.view.addSubview(rightButton)
            
            rightButton.setTitle(tit, for: UIControlState.normal)
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
