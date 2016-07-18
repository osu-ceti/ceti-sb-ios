//
//  ViewBadgeController.swift
//  Delphos
//
//  Created by Babu on 7/7/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewBadgeController: NavController {
    
    
    @IBOutlet var imgbadge: UIImageView!
      
    @IBOutlet var labelData: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
         rootViewController = self
        self.isBackEnabled = true
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Navbar
        //        setNavBar(self.view.frame.size.width)
        //        searchBar.delegate = self
        //        navigationBar.delegate = self;
        //        backToView = "HomeID"
        //
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
      
        
        let url = NSURL(string: AWS_S3 + viewBadgeBean.badge_url)
        var data = NSData(contentsOfURL:url!)
        if data != nil {
            self.imgbadge.image = UIImage(data:data!)
        }

        self.labelData.text = viewBadgeBean.event_owner! +
        " awarded " + viewBadgeBean.user_name!  + " a badge for speaking at the event: " + viewBadgeBean.event_name!
        + ", at " + viewBadgeBean.school_name!
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
