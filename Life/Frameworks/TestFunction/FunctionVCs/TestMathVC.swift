//
//  TestMathVC.swift
//  Life
//
//  Created by Wang, Devin on 6/30/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

import UIKit

class TestMathVC: TestFunctionBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var result  = 5 % 2;
        result = (5 % 2)^1;
        result = (4 % 2)^1;
        result = (4 / 2);
        result = (5 / 2);
        print(result);
//        result = ceilf(3.4);
//        result = ceilf(5 / 1.5);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
