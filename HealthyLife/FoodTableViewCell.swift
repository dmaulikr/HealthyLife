//
//  FoodTableViewCell.swift
//  HealthyLife
//
//  Created by admin on 7/27/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import NSDate_TimeAgo

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var loveCount: UILabel!
    @IBOutlet weak var loveImage: UIImageView!

    
    var food: Food!
    
    func configureCell(food : Food) {
        
        self.food = food
        
        desLabel.text = food.foodDes
        timeLabel.text = "\(food.time.timeAgo())"
        loveCount.text = "\(food.love)"
        
        foodImageView.downloadImageWithImageReference(food.imageRef)
        food.isLovedFood(withCompletion: { (thumbsUpDown) in
            self.loveImage.image = UIImage(named: (thumbsUpDown ? "love" : "loved"))
            }, needUpdate: false)

    }
    
    func loveTapped(sender: UITapGestureRecognizer) {
        
        food.isLovedFood(withCompletion: { (thumbsUpDown) in
            self.configureCell(self.food)
            }, needUpdate: true)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(FoodTableViewCell.loveTapped(_:)))
        tap.numberOfTapsRequired = 1
        loveImage.addGestureRecognizer(tap)
        loveImage.userInteractionEnabled = true
    }
    
    
}
