//
//  UserProfileController.swift
//  Delphos
//
//  Created by Babu on 6/13/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//


import UIKit
import QuartzCore


class UserProfileController:  NavController  {
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Navbar
        self.isBackEnabled = true
        
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        // navigationBar.delegate = self;
        //backToView = "HomeID"
        
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
