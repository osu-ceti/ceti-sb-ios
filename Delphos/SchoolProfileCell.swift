//
//  SchoolProfileCell.swift
//  Delphos
//
//  Created by Babu on 6/18/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

    import UIKit
    
    class SchoolProfileCell: UITableViewCell {
        
        
        
        @IBOutlet var eventTitle: UILabel!
        @IBOutlet var eventStartDate: UILabel!
        @IBOutlet var eventId: UILabel!
        
              override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
        
        
}
