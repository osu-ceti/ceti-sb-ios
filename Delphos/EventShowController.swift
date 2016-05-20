//
//  EventShowController.swift
//  Delphos
//
//  Created by Prabhu on 5/12/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class EventShowController: UIViewController {

    @IBOutlet weak var labeltext1: UILabel!
    @IBOutlet weak var labelText2: UILabel!
    @IBOutlet weak var labelText4: UILabel!
    @IBOutlet weak var labelText5: UILabel!
    @IBOutlet weak var labelText6: UILabel!
    @IBOutlet weak var labelText3: UILabel!

    @IBOutlet weak var txtText1: UILabel!
    @IBOutlet weak var txtText2: UILabel!
    @IBOutlet weak var txtText3: UILabel!
    @IBOutlet weak var txtText4: UILabel!
    @IBOutlet weak var txtText5: UILabel!
    @IBOutlet weak var txtText6: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var claim: UIButton!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(gBtnRadioValue == events || gObjShowEventBean != nil) {
            
            self.labeltext1.text = "Speaker:"
            self.labelText2.text = "Event Start:"
            self.labelText3.text = "Event End:"
            self.labelText4.text = "Event Location:"
            self.labelText5.text = "Event Username:"
            self.labelText6.text = "Event content:"
            
            self.txtTitle.text = gObjShowEventBean.title
            self.txtText1.text = gObjShowEventBean.speaker
            self.txtText2.text = gObjShowEventBean.event_start
            self.txtText3.text = gObjShowEventBean.event_end
            self.txtText4.text = gObjShowEventBean.loc_name
            self.txtText5.text = gObjShowEventBean.user_name
            self.txtText6.text = gObjShowEventBean.content
            
            if(gObjShowEventBean.claim_id > 0) {
                gClaim = "cancel"
                claim.setTitle( "Cancel", forState: .Normal)
            } else {
                gClaim = "claim"
            }
            
        } else if(gBtnRadioValue == users) {
            
            self.labeltext1.text = "Role:"
            self.labelText2.text = "Biography:"
            self.labelText3.hidden = true
            self.labelText4.hidden = true
            self.labelText5.hidden = true
            self.labelText6.hidden = true
            
            self.txtTitle.text = gObjSearchUserListBean.name
            self.txtText1.text = gObjSearchUserListBean.role
            self.txtText2.text = gObjSearchUserListBean.biography
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClaim(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        if(gClaim == "claim") {
            testfacade.doTask(self,action: DelphosAction.CLAIM_EVENT)
        } else if(gClaim == "cancel") {
            testfacade.doTask(self,action: DelphosAction.CANCEL_CLAIM)
        }

    }
}