//
//  EventShowControllerCells.swift
//  Delphos
//
//  Created by Babu on 6/1/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class EventShowControllerCells: UITableViewCell {
    
    
    
    @IBOutlet weak var claimUserName: UILabel!
    
    @IBOutlet weak var userId: UILabel!
    
       override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    


}
