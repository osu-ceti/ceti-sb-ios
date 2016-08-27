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
    
    @IBOutlet var labelAwardedBadge: UILabel!
    @IBOutlet var labelForEvent: UILabel!
    
    @IBOutlet weak var badgeImage: UIImageView!
    var txtEventName: String?
    var eventId:Int?
    var txtSpeakerName: String?
    var badgeUrl:String?
    var badgesAwardToEvent:Bool!
    
    var isAwarded:Bool = false
    @IBOutlet var msgAwardedBadge: UILabel!
    
    
    @IBOutlet var afterAwardedForEvent: UILabel!
    
    @IBOutlet var afterAwardedEventName: UILabel!
   
   // var awardResponse:[AwardBadgesResponse]!
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
        self.msgAwardedBadge.hidden = true
        self.view.backgroundColor = bgColor
       
        self.afterAwardedForEvent.hidden = true
        self.afterAwardedEventName.hidden = true
        self.speakerName.hidden = false
        self.labelAwardedBadge.hidden = false
        self.labelForEvent.hidden = false
        self.eventName.hidden = false
        
        eventName.text = txtEventName
        speakerName.text = txtSpeakerName
        
        
        
                
//                eventName.text = gEventTitle
//                speakerName.text = gActUserName
//                eventId = gEventID
        
//                if let url = NSURL(string:AWS_S3 + badgeUrl! ){
//                    var data = NSData(contentsOfURL:url)
//                    if data != nil {
//                        self.badgeImage.image = UIImage(data:data!)
//                    }
//                    
//                    
//                }
                if(isAwarded == true){
                    
                    self.msgAwardedBadge.hidden = false
                    self.afterAwardedForEvent.hidden = false
                    self.afterAwardedEventName.hidden = false
                    self.speakerName.hidden = true
                    self.labelAwardedBadge.hidden = true
                    self.labelForEvent.hidden = true
                    self.eventName.hidden = true
                    
                    self.afterAwardedEventName.text = gEventTitle
                    self.msgAwardedBadge.text = msgAwardedBadge.text! + gActUserName
                    self.btnAwardBadges.hidden = true
                    self.btnDoNotAward.hidden = true
                    
                    
                    
                }
                else{
                    ///Badge Not awarded yet
                    self.btnAwardBadges.hidden = false
                    self.btnDoNotAward.hidden = false
                }
            

        
        

       // badgeUrl
        self.showOverlay(self.view)
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
        
            if(self.badgeUrl != nil){
                print("self.badgeUrl : ", self.badgeUrl)
                if let url = NSURL(string:AWS_S3 + self.badgeUrl!){
                    var data = NSData(contentsOfURL:url)
                    if data != nil {
                         dispatch_async(dispatch_get_main_queue(), {
                            self.hideOverlayView()
                            self.badgeImage.image = UIImage(data:data!)
                        })
                    }

                }

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

