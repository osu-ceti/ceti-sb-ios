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

        
        if(gClaimUserName.characters.count > 0)
        {
            self.messageViewUserName.text = gClaimUserName
        }
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func touchSendMessage(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SEND_MESSAGE)
        
        
    }
 

}

