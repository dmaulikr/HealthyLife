//
//  mainTabbarViewController.swift
//  HealthyLife
//
//  Created by admin on 8/4/16.
//  Copyright © 2016 NHD group. All rights reserved.
//

import UIKit

class mainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print(item.tag)
        
        if item.tag == 0 {
            self.defaults.setBool(true, forKey: "checkID")
            self.defaults.setValue(FIRAuth.auth()?.currentUser?.uid, forKey: "currentID")
        }
    }
    
}
