//
//  DetailsViewController.swift
//  HealthyLife
//
//  Created by admin on 7/31/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {

    @IBOutlet weak var videoview: UIWebView!
    
    @IBOutlet weak var repTextField: UITextField!
    
    @IBOutlet weak var setTextField: UITextField!
    
    @IBOutlet weak var planTextField: UITextField!
    
    var selectedDemo: Demo!
    var ref =  FIRDatabase.database().reference()
    
    @IBAction func tapAction(sender: AnyObject) {
        view.endEditing(true)
        
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        let activity: Dictionary<String, AnyObject> = [
            "videoId": selectedDemo.idDemo,
            "name": selectedDemo.nameDemo,
            "rep" : repTextField.text!,
            "set" : setTextField.text!
            ]

        DataService.dataService.activitiesPlannedRef.child(planTextField.text!).childByAutoId().setValue(activity)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = selectedDemo.idDemo
        print(id)
        
        videoview.loadHTMLString("<iframe width=\"\(videoview.frame.width - 20 )\" height=\"\(videoview.frame.height)\" src=\"https://www.youtube.com/embed/\(id)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
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