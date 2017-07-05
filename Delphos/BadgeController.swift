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
    var badgeId:Int?
    var badgesAwardToEvent:Bool!
    
    var isAwarded:Bool = false
    @IBOutlet var msgAwardedBadge: UILabel!
    
    
    @IBOutlet var afterAwardedForEvent: UILabel!
    
    @IBOutlet var afterAwardedEventName: UILabel!
   
   // var awardResponse:[AwardBadgesResponse]!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
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
        self.msgAwardedBadge.isHidden = true
        self.view.backgroundColor = bgColor
       
        self.afterAwardedForEvent.isHidden = true
        self.afterAwardedEventName.isHidden = true
        self.speakerName.isHidden = false
        self.labelAwardedBadge.isHidden = false
        self.labelForEvent.isHidden = false
        self.eventName.isHidden = false
        
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
                    
                    
                    
                    self.msgAwardedBadge.isHidden = false
                    self.afterAwardedForEvent.isHidden = false
                    self.afterAwardedEventName.isHidden = false
                    self.speakerName.isHidden = true
                    self.labelAwardedBadge.isHidden = true
                    self.labelForEvent.isHidden = true
                    self.eventName.isHidden = true
                    
                    self.afterAwardedEventName.text = gEventTitle
                    self.msgAwardedBadge.text = msgAwardedBadge.text! + gActUserName
                    self.btnAwardBadges.isHidden = true
                    self.btnDoNotAward.isHidden = true
                    
                    if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
                    {
                        afterAwardedForEvent.frame.origin.x = 280
                        afterAwardedEventName.frame.origin.x = 350
                    }
                    
                    
                }
                else{
                    ///Badge Not awarded yet
                    self.btnAwardBadges.isHidden = false
                    self.btnDoNotAward.isHidden = false
                }
            

        
        

       // badgeUrl
        self.showOverlay(self.view)
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
        
            if(self.badgeUrl != nil){
               // print("self.badgeUrl : ", self.badgeUrl)
                if let url = URL(string:AWS_S3 + self.badgeUrl!){
                    var data = try? Data(contentsOf: url)
                    if data != nil {
                         DispatchQueue.main.async(execute: {
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
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        rootViewController = self
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.btnDoNotAward.frame.origin.y + 220)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    
    @IBAction func btnAwardBadgesClick(_ sender: AnyObject) {
        
        
        badgesAwardToEvent = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.badge_AWARD)
        
    }
    
    @IBAction func btnDoNotAwardClick(_ sender: AnyObject) {
        
        badgesAwardToEvent = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.badge_AWARD)
        
    }
    
}

