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
    var data = Data()
    override func viewWillAppear(_ animated: Bool) {
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
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        rootViewController = self
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.contactUs.frame.origin.y + 250)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       gObjRightViewController?.hideOverlayView()
           

        rootViewController = self
        settingSearch = false

        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            logoOntoborn.frame.origin.y = 20
            logoOntoborn.frame.origin.x = 320
        }
        
        self.view.backgroundColor = bgColor
        viewDetails.backgroundColor = bgColor
        

       self.logoOntoborn.image = UIImage(named:"ontobornlogo")
        
        
        //var label:UILabel!
        
        
    }
   
    
    @IBAction func StraightAGrantLink(_ sender: AnyObject) {
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
        
            let url : URL = URL(string:"http://education.ohio.gov/Topics/Straight-A-Fund/" )!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
      })
        
    }
        
    @IBAction func cetiLink(_ sender: AnyObject) {
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
        
            let url : URL = URL(string:"http://www.ceti.cse.ohio-state.edu/" )!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
        }
        })
    }
    @IBAction func ontobornClick(_ sender: AnyObject) {
       
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            let url : URL = URL(string: "http://ontoborn.com/")!
            if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
            }
        
        })
    }
        
    @IBAction func ourPrivacyPolicyClick(_ sender: AnyObject) {
        
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            
            let url : URL = URL(string:"https://www.school2biz.com/privacy_policy" )!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        })
    }
    @IBAction func ontobornUrlClick(_ sender: AnyObject) {
        
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            let url : URL = URL(string: "http://ontoborn.com/")!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
            
        })
    }
    @IBAction func contactUsLink(_ sender: AnyObject) {
        
        let shareData = ""
        
        //let imageUrl: UIImage = UIImage(data: data)!
        
        
        let activityVC = UIActivityViewController(activityItems: [shareData], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = sender as! UIView
        self.present(activityVC, animated: true, completion: nil)

    }
   
}




