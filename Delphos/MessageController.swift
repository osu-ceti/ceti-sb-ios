//
//  MessageController.swift
//  Delphos
//
//  Created by Babu on 6/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation


import UIKit
import QuartzCore


class MessageController:  NavController  {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        menus = regularMenu
//        rightViewController.isRegister = false
//        rightViewController.tableView.reloadData()
//        
        self.isBackEnabled = false
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        radioButtonController!.delegate = self
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
 

}

