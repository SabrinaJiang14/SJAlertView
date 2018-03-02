//
//  ViewController.swift
//  SJAlertView
//
//  Created by Eileen on 2018/3/2.
//  Copyright © 2018年 Eileen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("Click Me", for: UIControlState.normal)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(button_Click), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @objc func button_Click(){
        let alert = SJAlertView()
        alert.setView(title: "Title", mssage: "Massage", lButtontitle: "Button 1", rButtonTitle: "Button 2", lButtonColor: UIColor.blue, rButtonColor: UIColor.white, radius: 5, leftAction: {
            print("Left Button Action")
        }, rightAction: {
            print("Right Button Action")
        })
        self.present(alert, animated: true, completion: nil)
    }
}

