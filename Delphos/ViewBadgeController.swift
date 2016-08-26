//
//  ViewBadgeController.swift
//  Delphos
//
//  Created by Babu on 7/7/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper
import Social

class ViewBadgeController: NavController {
    
    
    @IBOutlet var imgbadge: UIImageView!
      
    @IBOutlet var labelData: UILabel!
    
    
    
    @IBOutlet var btnShareBadge: UIButton!
   
    
    var data = NSData()
    
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
      
        self.hideOverlayView()
        //Adding Navbar
        //        setNavBar(self.view.frame.size.width)
        //        searchBar.delegate = self
        //        navigationBar.delegate = self;
        //        backToView = "HomeID"
        //
        
        gObjBackTocontroller = gObjUserProfileNavController
        self.view.backgroundColor = bgColor
      
        self.btnShareBadge.hidden = true
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            dispatch_async(dispatch_get_main_queue(), {
        
                let url = NSURL(string: AWS_S3 + viewBadgeBean.badge_url)
                self.data = NSData(contentsOfURL:url!)!
                if self.data != "" {
                    self.imgbadge.image = UIImage(data:self.data)
                }
            })
        })
        self.labelData.text = viewBadgeBean.event_owner! +
        " awarded " + viewBadgeBean.user_name!  + " a badge for speaking at the event: " + viewBadgeBean.event_name!
        + ", at " + viewBadgeBean.school_name!
        
        if(gObjUserBean.name == viewBadgeBean.user_name){
            
            self.btnShareBadge.hidden = false
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnShareBadgeClick(sender: AnyObject) {
        print("share")
        
        let shareData =  viewBadgeBean.event_owner! +
            " awarded " + viewBadgeBean.user_name!  + " a badge for speaking at the event: " + viewBadgeBean.event_name!
            + ", at " + viewBadgeBean.school_name!
        
        let imageUrl: UIImage = UIImage(data: data)!
//        
//        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [(imageUrl), shareData], applicationActivities: nil)
//        self.presentViewController(shareVC, animated: true, completion: nil)
        
        let activityVC = UIActivityViewController(activityItems: [(imageUrl), shareData], applicationActivities: nil)
        
          activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.presentViewController(activityVC, animated: true, completion: nil)
       
          
        
    }
   

}
