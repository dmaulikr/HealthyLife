//
//  uploadFoodViewController.swift
//  HealthyLife
//
//  Created by admin on 7/27/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase

class uploadFoodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref =  FIRDatabase.database().reference()
    let currentUserID = FIRAuth.auth()?.currentUser?.uid
    var key = ""
    let storageRef = FIRStorage.storage().reference()
    
    
    @IBOutlet weak var FoodImageView: UIImageView!
    
    @IBAction func tapAction(sender: AnyObject) {
        view.endEditing(true)
        
    }
    //MARK: Set up camera and photo lib for uploading photos.
    
    @IBAction func cameraAction(sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)


    }
    
    
    @IBAction func photoLibAction(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        FoodImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //MARK: Set Up action upload JSON data to firebase realtime database and Photo to Firebase Storage.
    
    @IBAction func uploadAction(sender: UIButton) {
        
        guard let foodImage = FoodImageView.image else {
            
            Helper.showAlert("Error", message: "Please choose an image to upload", inViewController: self)
            return
        }
        
        FoodManager.uploadFood(foodDesTextField.text, image: foodImage, withCompletion: {
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }) { (error) in
            Helper.showAlert("Error", message: error.localizedDescription, inViewController: self)
        }
    }
    
     //******************************************************************************************************
    
    
    @IBOutlet weak var foodDesTextField: UITextField!
    
    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
