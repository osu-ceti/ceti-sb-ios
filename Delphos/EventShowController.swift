//
//  EventShowController.swift
//  Delphos
//
//  Created by Prabhu on 5/12/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class EventShowController: NavController, UITableViewDataSource, UITableViewDelegate {

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
   
    @IBOutlet weak var labelBusiness: UILabel!
    @IBOutlet weak var labelJobTitle: UILabel!
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var mainLabelBusiness: UILabel!
       
    @IBOutlet weak var mainLabelJobTitle: UILabel!
    @IBOutlet weak var cancelClaim: UIButton!
    @IBOutlet weak var cancelEvent: UIButton!
   
    @IBOutlet weak var btnLinkSpeaker: UIButton!
    @IBOutlet weak var btnLinkLocation: UIButton!
    @IBOutlet weak var btnLinkCreatedBy: UIButton!
    
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    
    @IBOutlet weak var labelClaims: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
   
    var claimBeanArray: [ClaimListClaimBeanBean]? = []
   // var acceptClaimBeanDetails: ShowEventBean?
   
    var name = ["claim"]
    var selectedClaimId:Int = 0
    var selectedEventId:Int = 0
    var currentDate = NSDate()
    
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
    
    
    
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.CLAIM_LIST)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelClaims.hidden = true
        self.labelUserName.hidden = true
        self.mainLabelBusiness.hidden = true
        self.mainLabelJobTitle.hidden = true
        self.labelBusiness.hidden = true
        self.labelJobTitle.hidden = true
        self.tableView.hidden = true
        
        self.btnMessage.hidden = true
        self.btnAccept.hidden = true
        self.btnReject.hidden = true
        
        self.editEvent.hidden = true
        self.cancelEvent.hidden = true
        self.claim.hidden = true
        self.cancelClaim.hidden = true
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
     
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gDateTimeFormat
        
        txtTitle.font = UIFont.boldSystemFontOfSize(15)
        labeltext1.font = UIFont.boldSystemFontOfSize(15)
        labelText2.font = UIFont.boldSystemFontOfSize(15)
        labelText3.font = UIFont.boldSystemFontOfSize(15)
        labelText4.font = UIFont.boldSystemFontOfSize(15)
        labelText5.font = UIFont.boldSystemFontOfSize(15)
        labelText6.font = UIFont.boldSystemFontOfSize(15)
    
        
        if(gBtnRadioValue == events || gObjShowEventBean != nil) {
            
            self.labeltext1.text = "Speaker:"
            self.labelText2.text = "Event Start:"
            self.labelText3.text = "Event End:"
            self.labelText4.text = "Location:"
            self.labelText5.text = "Created By:"
            self.labelText6.text = "Content:"
           gSpeakerId = Int(gObjShowEventBean.speaker_id)
            gSpeakerName =  String(gObjShowEventBean.speaker)

            btnLinkSpeaker.setTitle( gObjShowEventBean.speaker, forState: .Normal)
            btnLinkLocation.setTitle(gObjShowEventBean.loc_name, forState: .Normal)
            btnLinkCreatedBy.setTitle(gObjShowEventBean.user_name, forState: .Normal)
            
            if (gObjShowEventBean.active == false)
            {
                var titleLength = gObjShowEventBean.title.characters.count
                var attributedString = NSMutableAttributedString(string: gObjShowEventBean.title as String)
                let secondAttributes = [NSForegroundColorAttributeName: UIColor.redColor(),  NSStrikethroughStyleAttributeName: 1]
                attributedString.addAttributes(secondAttributes, range: NSRange(location: 0,length:titleLength))
                self.txtTitle.attributedText = attributedString
   
            }
            
            else{
            self.txtTitle.text = gObjShowEventBean.title
            }
           
            //self.txtText1.text =    gObjShowEventBean.speaker
            self.txtText2.text   =    gObjShowEventBean.event_start
            self.txtText3.text   =    gObjShowEventBean.event_end
            //self.txtText4.text =    gObjShowEventBean.loc_name
            //self.txtText5.text =    gObjShowEventBean.user_name
            self.txtText6.text   =    gObjShowEventBean.content
           
            
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a zzz"
            let minusCurrentDate = currentDate.dateByAddingTimeInterval(-1*24*60*60);
            var endDate = dateFormatter.dateFromString(gObjShowEventBean.event_end)
            
            //self.setNavigationBarItem()
           
            if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
                RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH){
                
                
                if (endDate!.timeIntervalSinceReferenceDate < minusCurrentDate.timeIntervalSinceReferenceDate) {
                    self.editEvent.hidden = true
                    self.cancelEvent.hidden = true
                    self.claim.hidden = true
                    self.cancelClaim.hidden = true
                }
                else if(gObjUserBean.id == gObjShowEventBean.user_id){
                    self.editEvent.hidden = false
                    self.cancelEvent.hidden = false
                    self.claim.hidden = true
                    self.cancelClaim.hidden = true
                   
                    
                    gCancelEvent = "cancelEvent "
                    gEditEvent = "EditEvent"
                    cancelEvent.setTitle( "Cancel Event", forState: .Normal)
                    editEvent.setTitle( "Edit Event", forState: .Normal)
                    //gEditEvent.frame = CGRectMake
                }
                else{
                    self.editEvent.hidden = true
                    self.cancelEvent.hidden = true
                    self.claim.hidden = false
                    self.cancelClaim.hidden = true
                }

            }
//            else if (gObjUserBean.id == gObjShowEventBean.speaker_id) {
//                
//                self.editEvent.hidden = true
//                self.cancelEvent.hidden = true
//                self.claim.hidden = true
//                
//                self.cancelClaim.hidden = false
//                
//                gCancelClaim = "cancelClaim"
//                gClaim = "claim"
//                cancelClaim.setTitle( "Cancel Claim", forState: .Normal)
//                claim.setTitle( "Claim", forState: .Normal)
//                
//                
//            }
           
            
            
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
        
        
        
//        overlay = UIView(frame: view.frame)
//        overlay!.backgroundColor = UIColor.blackColor()
//        overlay!.alpha = 0.8
        
//        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
//        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
//        activityIndicator.center = CGPointMake(overlay!.bounds.width / 2, overlay!.bounds.height / 2)
        
        
        
       
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return claimBeanArray!.count
           // claimBeanArray!.count
        
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
         //cell.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        if(gObjUserBean.id == gObjShowEventBean.user_id){
            if(claimBeanArray?.count > 0 &&  gSpeakerId == 0 &&
                (RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
                    RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH)){
            
                self.labelClaims.hidden = false
                self.tableView.hidden  = false
            
                var claimDisplayBean: ClaimListClaimBeanBean! = claimBeanArray![indexPath.row]
                      
                gClaimUserName = claimDisplayBean.user_name
                gClaimUser_id = claimDisplayBean.user_id
                (cell as! EventShowControllerCells).claimUserName!.text = String(claimDisplayBean.user_name)
                (cell as! EventShowControllerCells).userId!.text =  String(claimDisplayBean.event_id)
                
            }
        }
        else{
            self.tableView.hidden = true
        
        }
        
    }
    
    //function to return dynamic cell
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ClaimCell", forIndexPath: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! EventShowControllerCells
        print("currentCell", currentCell.userId.text!)
        
        gClaimDetailId = Int(currentCell.userId.text!)
        gUserId = Int(currentCell.userId.text!)
        
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.CLAIM_LIST_DETAILS)
           
        self.tableView.hidden = true
        self.mainLabelJobTitle.hidden = false
        self.mainLabelBusiness.hidden = false
        self.labelUserName.hidden = false
        self.labelBusiness.hidden = false
        self.labelJobTitle.hidden = false
        self.editEvent.hidden = true
        self.cancelEvent.hidden = true
       
        self.claim.hidden = true
        self.cancelClaim.hidden = true
        if(gObjUserBean.id == gObjShowEventBean.user_id){
            self.btnMessage.hidden = false
            self.btnAccept.hidden = false
            self.btnReject.hidden = false
        }
        else{
            self.btnMessage.hidden = true
            self.btnAccept.hidden = true
            self.btnReject.hidden = true
        
        }
        
    }

    @IBAction func btnSendMessage(sender: AnyObject) {
        
        //showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.VIEW_MESSAGE_CONTROLLER)
       
        
    }
    @IBAction func btnTouchAccept(sender: AnyObject) {
        
        //showOverlay(self.view)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.CLAIM_ACCEPT)
         // var claimAcceptDisplayBean: ShowEventBean! = acceptClaimBeanArray![1]
        
        
       

        self.labelUserName.hidden = true
        self.mainLabelBusiness.hidden = true
        self.mainLabelJobTitle.hidden = true
        self.labelBusiness.hidden = true
        self.labelJobTitle.hidden = true
        self.tableView.hidden = false
        
        self.btnMessage.hidden = false
        self.btnAccept.hidden = false
        self.btnReject.hidden = false
        self.editEvent.hidden = true
        self.cancelEvent.hidden = true
        
    }
    
    
    @IBAction func btnTouchReject(sender: AnyObject) {
        
      // showOverlay(self.view)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.CLAIM_REJECT)
        
        self.labelUserName.hidden = true
        self.mainLabelBusiness.hidden = true
        self.mainLabelJobTitle.hidden = true
        self.labelBusiness.hidden = true
        self.labelJobTitle.hidden = true
       self.tableView.hidden = false
        
        self.btnMessage.hidden = false
        self.btnAccept.hidden = false
        self.btnReject.hidden = false
        self.editEvent.hidden = true
        self.cancelEvent.hidden = true
       
    }
    
    
    
    @IBAction func btnEditEvent(sender: AnyObject) {
        showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EDIT_EVENT_SHOW)

        

    }
    @IBAction func btnClaim(sender: AnyObject) {
        
       showOverlay(self.view)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.CLAIM_EVENT)
        
       
    }
    
    @IBAction func btnCancelClaim(sender: AnyObject) {
   
        showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.CANCEL_CLAIM)
    }
    @IBAction func btnDeleteEvent(sender: AnyObject) {
         showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.CANCEL_EVENT)
        
    }
    @IBAction func btnSpeaker(sender: AnyObject) {
    }
    @IBAction func btnLocation(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SHOW_SCHOOL_PROFILE)
        

    }
    @IBAction func btnCreatedBy(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SHOW_USER_PROFILE)

    }
    
}