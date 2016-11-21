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
    
    @IBOutlet var requiredField: UILabel!
    var userMessageId:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewController = self
        //Adding Navbar
        self.isBackEnabled = true
        
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
       // navigationBar.delegate = self;
        //backToView = "HomeID"
        
        
        self.view.backgroundColor = bgColor
        self.requiredField.isHidden = true
        
         messageViewUserName.font = UIFont.boldSystemFont(ofSize: 15)
         labelSendMessage.font = UIFont.boldSystemFont(ofSize: 15)
        
       
        if (gUserProfileMessage == true)
        {
            self.messageViewUserName.text = gObjSearchUserListBean.name
            userMessageId = gObjSearchUserListBean.id
        
        }
        else{
            if(RoleType(rawValue:UInt(gObjUserBean.role!)) == RoleType.teacher ||
                RoleType(rawValue:UInt(gObjUserBean.role!)) == RoleType.both){
       
                self.messageViewUserName.text = gClaimSpeakerName
                //userMessageId = gClaimUser_id
            }
            else if(RoleType(rawValue:UInt(gObjUserBean.role!)) == RoleType.speaker){
            
                self.messageViewUserName.text = gObjShowEventBean.user_name
        
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.btnSendMessage.frame.origin.y + 350)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func touchSendMessage(_ sender: AnyObject) {
        
        var trimmedName = txtSendMessage.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines
        )
        
        if(trimmedName == DelphosStrings.EMPTY_STRING){
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Message"
            
        }
        else{
        
            //showOverlay(self.view)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.send_MESSAGE)
        
        }
    }
 

}

