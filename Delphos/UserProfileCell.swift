//
//  UserProfileCell.swift
//  Delphos
//
//  Created by Babu on 6/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//



import UIKit

class UserProfileCell: UITableViewCell {
    
    @IBOutlet var eventTitle: UILabel!
    
    @IBOutlet var eventStartDate: UILabel!
    @IBOutlet var eventId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}