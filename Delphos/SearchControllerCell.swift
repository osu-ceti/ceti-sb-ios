//
//  EventDsiplayCell.swift
//  Delphos
//
//  Created by Prabhu on 5/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

/**
 * Controller handles the SearchResultCell for searchResult controller
 */
class SearchControllerCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtIdHidden: UILabel!
    
      @IBOutlet weak var startdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
