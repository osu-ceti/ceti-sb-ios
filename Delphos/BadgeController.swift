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
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        eventName.text = txtEventName
        speakerName.text = txtSpeakerName
        
        let url = NSURL(string:AWS_S3 + badgeUrl!)
        var data = NSData(contentsOfURL:url!)
        if data != nil {
            self.badgeImage.image = UIImage(data:data!)
        }

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

