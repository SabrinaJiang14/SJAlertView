//
//  CustomPresentationController.swift
//  SJDatePicker
//
//  Created by Sabrina on 2017/4/12.
//  Copyright © 2017年 Sabrina. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {

    static let viewLeftPadding:CGFloat = 40
    static let viewTopPadding:CGFloat = UIScreen.main.bounds.size.height / 3
    static let buttonTopPadding:CGFloat = 100
    static let buttonHeight:CGFloat = 100
    static let viewHeight:CGFloat = 100
    static let viewNeedAddPadding: CGFloat = 25
    
    var dimmingView:UIButton = UIButton.init()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        
        dimmingView.frame = containerView.bounds
        dimmingView.backgroundColor = UIColor.black
        dimmingView.alpha = 0.0
//        dimmingView.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        containerView.addSubview(dimmingView)

        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context) in
                self.dimmingView.alpha = 0.7
            }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentedViewController.transitionCoordinator{
            transitionCoordinator.animate(alongsideTransition: { (context) in
                self.dimmingView.alpha = 0.0
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }

    override var frameOfPresentedViewInContainerView:CGRect {
        guard let containerView = containerView else {
            print("Not find view")
            return CGRect()
        }
        
        var frame = containerView.bounds
        
        let newOriginX = CustomPresentationController.viewLeftPadding

        frame = frame.insetBy(dx: newOriginX, dy: 15)
        return frame
        //!!!: Here is the calculated view size of dismiss
    }
    
    @objc func dismissSelf(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
