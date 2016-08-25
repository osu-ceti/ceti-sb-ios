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
        
       // let bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        eventName.text = txtEventName
        speakerName.text = txtSpeakerName
        
        if(eventName.text == nil && speakerName.text == nil){
        
            if(gEventTitle != nil){
                eventName.text = gEventTitle
                speakerName.text = gActUserName
                eventId = gEventID
                
                if let url = URL(string:AWS_S3 + "def_school_badge_small.jpg"){
                    let data = try? Data(contentsOf: url)
                    if data != nil {
                        self.badgeImage.image = UIImage(data:data!)
                    }
                    
                    
                }
                if(gAwardNtype == 4){
                    self.btnAwardBadges.isHidden = false
                    self.btnDoNotAward.isHidden = false
                    
                }
                else{
                    self.btnAwardBadges.isHidden = true
                    self.btnDoNotAward.isHidden = true
                }
            }

        }
        

       // badgeUrl
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            
            if(self.badgeUrl != nil){
                if let url = URL(string:AWS_S3 + self.badgeUrl!){
                    let data = try? Data(contentsOf: url)
                    if data != nil {
                self.badgeImage.image = UIImage(data:data!)
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

