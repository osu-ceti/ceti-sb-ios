//
//  BadgeController.swift
//  Delphos
//
//  Created by Babu on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

//
//  BadgesAwardController.swift
//  Delphos
//
//  Created by Babu on 7/4/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class BadgeController: NavController {
    
    @IBOutlet weak var speakerName: UILabel!
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet var btnAwardBadges: UIButton!
    
    @IBOutlet var btnDoNotAward: UIButton!
    
    @IBOutlet weak var badgeImage: UIImageView!
    var txtEventName: String?
    var eventId:Int?
    var txtSpeakerName: String?
    var badgeUrl:String?
    var badgesAwardToEvent:Bool!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = true
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewController = self
        
        self.view.backgroundColor = bgColor
        
        eventName.text = txtEventName
        speakerName.text = txtSpeakerName
        
        if(eventName.text == nil && speakerName.text == nil){
        
            if(gEventTitle != nil){
                eventName.text = gEventTitle
                speakerName.text = gActUserName
                eventId = gEventID
                
                if let url = NSURL(string:AWS_S3 + "def_school_badge_small.jpg"){
                    var data = NSData(contentsOfURL:url)
                    if data != nil {
                        self.badgeImage.image = UIImage(data:data!)
                    }
                    
                    
                }
                if(gAwardNtype == 4 ){
                    self.btnAwardBadges.hidden = false
                    self.btnDoNotAward.hidden = false
                    
                }
                else{
                    self.btnAwardBadges.hidden = true
                    self.btnDoNotAward.hidden = true
                }
            }

        }
        

       // badgeUrl
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            if(self.badgeUrl != nil){
                if let url = NSURL(string:AWS_S3 + self.badgeUrl!){
                    var data = NSData(contentsOfURL:url)
                    if data != nil {
                         dispatch_async(dispatch_get_main_queue(), {
                            self.badgeImage.image = UIImage(data:data!)
                        })
                    }

                }
                self.btnAwardBadges.hidden = false
                self.btnDoNotAward.hidden = false
          }
           
        })
        
        
      
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        rootViewController = self
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnDoNotAward.frame.origin.y + 220)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
    }
    
    @IBAction func btnAwardBadgesClick(sender: AnyObject) {
        
        
        badgesAwardToEvent = true
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.BADGE_AWARD)
        
    }
    
    @IBAction func btnDoNotAwardClick(sender: AnyObject) {
        
        badgesAwardToEvent = false
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.BADGE_AWARD)
        
    }
    
}

