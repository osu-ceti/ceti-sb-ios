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
   
    
    var data = Data()
    
    override func viewWillAppear(_ animated: Bool) {
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
        //var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
      
        self.btnShareBadge.isHidden = true
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            
            DispatchQueue.main.async(execute: {
        
                let url = URL(string: AWS_S3 + viewBadgeBean.badge_url)
                self.data = try! Data(contentsOf: url!)
                if self.data != nil {
                    self.imgbadge.image = UIImage(data:self.data)
                }
            })
        })
        self.labelData.text = viewBadgeBean.event_owner! +
        " awarded " + viewBadgeBean.user_name!  + " a badge for speaking at the event: " + viewBadgeBean.event_name!
        + ", at " + viewBadgeBean.school_name!
        
        if(gObjUserBean.name == viewBadgeBean.user_name){
            
            self.btnShareBadge.isHidden = false
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnShareBadgeClick(_ sender: AnyObject) {
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
            self.present(activityVC, animated: true, completion: nil)
       
          
        
    }
   

}
