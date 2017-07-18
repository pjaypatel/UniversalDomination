//
//  TestViewController.swift
//  UniversalDomination
//
//  Created by Pranay Jay Patel on 6/29/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    private var testVar = 0
    
    public func setTestVar(test: Int)
    {
        testVar = test
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
