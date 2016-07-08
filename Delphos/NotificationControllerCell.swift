//
//  NotificationControllerCell.swift
//  Delphos
//
//  Created by Babu on 7/2/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class NotificationControllerCell: UITableViewCell {
    
    
    @IBOutlet var actUSerName: UILabel!
    
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventId: UILabel!
    
    @IBOutlet var UserNotificationType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
