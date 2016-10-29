//
//  TestSwiftVC.swift
//  Life
//
//  Created by Wang, Devin on 6/28/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

import UIKit

class TestSwiftVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let testKeyBoard = TestKeyboardVC(init)
        // Do any additional setup after loading the view.
        let btn = UIButton(frame:CGRect(origin: CGPointMake(10.0, 110.0), size: CGSizeMake(150,50)))
        btn.setTitle("button", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: #selector(TestSwiftVC.buttonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonClick(sender:UIButton!) {
        NSLog("%@", "asdf")
    }
}
