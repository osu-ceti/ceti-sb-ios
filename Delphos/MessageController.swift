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

    @IBOutlet weak var txtSendMessage: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
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

        
        if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
            RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH){
       
            self.messageViewUserName.text = gClaimUserName
        }
        else if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.SPEAKER){
            
            self.messageViewUserName.text = gObjShowEventBean.user_name
        
        }
        
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

