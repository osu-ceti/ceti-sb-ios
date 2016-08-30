//
//  AboutController.swift
//  Delphos
//
//  Created by Babu on 8/14/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class AboutController: NavController {
    
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var logoOntoborn: UIImageView!
    
    @IBOutlet var ontobornUrl: UIButton!
    
   
    @IBOutlet var viewDetails: UIView!
    
  
    @IBOutlet var contactUs: UIButton!
    
    @IBOutlet var firstLabel: UILabel!
    var data = NSData()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = false
        self.hideOverlayView()
        
        setNavBar(self.view.frame.size.width)
        
        //setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
       
    }
    @IBOutlet var viewSetting: UIView!
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        rootViewController = self
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.contactUs.frame.origin.y + 250)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       gObjRightViewController.hideOverlayView()
           

        rootViewController = self
        settingSearch = false

        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            logoOntoborn.frame.origin.y = 20
            logoOntoborn.frame.origin.x = 320
        }
        
        self.view.backgroundColor = bgColor
        viewDetails.backgroundColor = bgColor
        

       self.logoOntoborn.image = UIImage(named:"ontobornlogo")
        
        
        //var label:UILabel!
        
        
    }
   
    
    @IBAction func StraightAGrantLink(sender: AnyObject) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
        
            let url : NSURL = NSURL(string:"http://education.ohio.gov/Topics/Straight-A-Fund/" )!
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            }
      })
        
    }
        
    @IBAction func cetiLink(sender: AnyObject) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
        
            let url : NSURL = NSURL(string:"http://www.ceti.cse.ohio-state.edu/" )!
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
        }
        })
    }
    @IBAction func ontobornClick(sender: AnyObject) {
       
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            let url : NSURL = NSURL(string: "http://ontoborn.com/")!
            if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
            }
        
        })
    }
        
    @IBAction func ourPrivacyPolicyClick(sender: AnyObject) {
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            let url : NSURL = NSURL(string:"https://www.school2biz.com/privacy_policy" )!
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            }
        })
    }
    @IBAction func ontobornUrlClick(sender: AnyObject) {
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            let url : NSURL = NSURL(string: "http://ontoborn.com/")!
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            }
            
        })
    }
    @IBAction func contactUsLink(sender: AnyObject) {
        
        let shareData = ""
        
        //let imageUrl: UIImage = UIImage(data: data)!
        
        
        let activityVC = UIActivityViewController(activityItems: [shareData], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = sender as! UIView
        self.presentViewController(activityVC, animated: true, completion: nil)

    }
   
}



