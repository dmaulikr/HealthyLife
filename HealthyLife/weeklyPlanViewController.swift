//
//  weeklyPlanViewController.swift
//  HealthyLife
//
//  Created by admin on 8/1/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase

class weeklyPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfKey = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.dataService.activitiesPlannedRef.observeEventType(.Value, withBlock: { snapshot in
            
           
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                
                self.arrayOfKey = []
                
                for snap in snapshots {
                    let key = snap.key
                        self.arrayOfKey.insert(key, atIndex: 0)
                    
                }
                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
            //            MBProgressHUD.hideHUDForView(self.view, animated: true)

        })
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfKey.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("weekly")
        cell?.textLabel?.text = arrayOfKey[indexPath.row]
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(arrayOfKey[indexPath.row], forKey: "key")
        print(arrayOfKey[indexPath.row])
        
    }

   
}
