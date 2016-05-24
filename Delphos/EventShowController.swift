//
//  EventShowController.swift
//  Delphos
//
//  Created by Prabhu on 5/12/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class EventShowController: NavController {

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
    @IBOutlet weak var editEvent: UIButton!
    @IBOutlet weak var cancelEvent: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTitle.font = UIFont.boldSystemFontOfSize(15)
        labeltext1.font = UIFont.boldSystemFontOfSize(15)
        labelText2.font = UIFont.boldSystemFontOfSize(15)
        labelText3.font = UIFont.boldSystemFontOfSize(15)
        labelText4.font = UIFont.boldSystemFontOfSize(15)
        labelText5.font = UIFont.boldSystemFontOfSize(15)
        labelText6.font = UIFont.boldSystemFontOfSize(15)
    
        
        //Adding Navbar
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        navigationBar.delegate = self;
        backToView = "HomeID"
        

        
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
            
            //self.setNavigationBarItem()
            if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
                RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH){
                
                self.editEvent.hidden = false
                self.editEvent.hidden = false
                self.claim.hidden = true
                gCancelEvent = "cancel"
                gEditEvent = "EditEvent"
                editEvent.setTitle( "EditEvent", forState: .Normal)
                cancelEvent.setTitle( "Cancel", forState: .Normal)
                

            }
            else{
                
                self.editEvent.hidden = true
                self.cancelEvent.hidden = true
                gClaim = "claim"
                 claim.setTitle( "claim", forState: .Normal)
                //claim.frame = CGRectMake(0, 600, 100, 50)
                
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

    @IBAction func btnEditEvent(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("CreateEventId") as! CreateEventController
        nextViewController.isEdit = true
        self.presentViewController(nextViewController,animated:true,completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func btnClaim(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.CLAIM_EVENT)
       
    }
    @IBAction func btnCancelEvent(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.CANCEL_CLAIM)
    }
}