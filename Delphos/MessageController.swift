//
//  MessageController.swift
//  Delphos
//
//  Created by Babu on 6/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation


import UIKit
import QuartzCore


class MessageController:  NavController  {

    @IBOutlet weak var messageViewUserName: UILabel!
   

    @IBOutlet var labelSendMessage: UILabel!
    @IBOutlet weak var txtSendMessage: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSendMessage: UIButton!
    
    var userMessageId:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Navbar
        self.isBackEnabled = true
        
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
       // navigationBar.delegate = self;
        //backToView = "HomeID"
        
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        messageViewUserName.font = UIFont.boldSystemFontOfSize(15)
         labelSendMessage.font = UIFont.boldSystemFontOfSize(15)
        
        if (gUserProfileMessage == true)
        {
            self.messageViewUserName.text = gObjSearchUserListBean.name
            userMessageId = gObjSearchUserListBean.id
        
        }
        else{
            if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
                RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH){
       
                self.messageViewUserName.text = gClaimSpeakerName
                //userMessageId = gClaimUser_id
            }
            else if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.SPEAKER){
            
                self.messageViewUserName.text = gObjShowEventBean.user_name
        
            }
        }
        
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnSendMessage.frame.origin.y + 400)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func touchSendMessage(sender: AnyObject) {
        
        //showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SEND_MESSAGE)
        
        
    }
 

}

