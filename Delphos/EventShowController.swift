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
   
    @IBOutlet var labeltext1: UILabel!

    @IBOutlet var labelText2: UILabel!
   
    @IBOutlet var labelText3: UILabel!
    @IBOutlet var labelText4: UILabel!
    @IBOutlet var labelText5: UILabel!
    
    @IBOutlet var labelText6: UILabel!
    
    @IBOutlet var txtText2: UILabel!
    @IBOutlet var txtText3: UILabel!
    
    @IBOutlet var txtText6: UILabel!
    
   
    
    @IBOutlet var txtTitle: UILabel!
    
    @IBOutlet var editEvent: UIButton!
    @IBOutlet var cancelEvent: UIButton!
    @IBOutlet var claim: UIButton!
    @IBOutlet var cancelClaim: UIButton!

 
   
   
    @IBOutlet weak var mainLabelJobTitle: UILabel!
    @IBOutlet weak var mainLabelBusiness: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
       
   
    @IBOutlet weak var labelJobTitle: UILabel!
    @IBOutlet weak var labelBusiness: UILabel!
   
    
    @IBOutlet var btnLinkSpeaker: UIButton!
    @IBOutlet var btnLinkLocation: UIButton!
    @IBOutlet var btnLinkCreatedBy: UIButton!
    
    @IBOutlet var btnAccept: UIButton!
    @IBOutlet var btnMessage: UIButton!
    @IBOutlet var btnReject: UIButton!
    
    @IBOutlet var labelClaims: UILabel!
    
    @IBOutlet var tableView: UITableView!
   
   
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    
    var schoolProfileId:Int!
   
    var claimBeanArray: [ClaimListClaimBeanBean]? = []
   // var acceptClaimBeanDetails: ShowEventBean?
   
    var name = ["claim"]
    var selectedClaimId:Int = 0
    var selectedEventId:Int = 0
    var currentDate = NSDate()
   
    var dateFormatter = NSDateFormatter()
    var minusCurrentDate = NSDate()
    var endDate = NSDate()
    var startDateAndTime = NSDate()
    
    var tempBackToViewController: UIViewController!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(tempBackToViewController != nil){
            gObjBackTocontroller = tempBackToViewController
            tempBackToViewController = nil
        }
        self.isBackEnabled = true
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        
            //Adding Navbar
//        menus = regularMenu
//        rightViewController.isRegister = false
//        rightViewController.tableView.reloadData()
        
       
        
       // backToController = gObjHomeController
    
    
    
    
        

        
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        rootViewController = self
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.cancelClaim.frame.origin.y + 250)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
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
        
        self.view.backgroundColor = bgColor
        
        self.tableView.backgroundColor = bgColor
        self.tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        
//        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gDateTimeFormat
        
        txtTitle.font = UIFont.boldSystemFontOfSize(15)
        labeltext1.font = UIFont.boldSystemFontOfSize(15)
        labelText2.font = UIFont.boldSystemFontOfSize(15)
        labelText3.font = UIFont.boldSystemFontOfSize(15)
        labelText4.font = UIFont.boldSystemFontOfSize(15)
        labelText5.font = UIFont.boldSystemFontOfSize(15)
        labelText6.font = UIFont.boldSystemFontOfSize(15)
    
        
        if(gObjShowEventBean != nil) {
            

            
            self.labeltext1.text = "Speaker:"
            self.labelText2.text = "Event Start:"
            self.labelText3.text = "Event End:"
            self.labelText4.text = "Location:"
            self.labelText5.text = "Created By:"
            self.labelText6.text = "Content:"
            if(gObjShowEventBean.speaker_id != nil){
                gSpeakerId = Int(gObjShowEventBean.speaker_id)
            }
            
            if(gObjShowEventBean.speaker != nil){
                 gSpeakerName =  String(gObjShowEventBean.speaker)
                 btnLinkSpeaker.setTitle( gObjShowEventBean.speaker, forState: .Normal)
            }
            
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
            minusCurrentDate = currentDate.dateByAddingTimeInterval(-1*24*60*60);

            print("End Date = " + gObjShowEventBean.event_end)
            
            if(!gObjShowEventBean.event_end.containsString("AM") && !gObjShowEventBean.event_end.containsString("PM")){
                logger.log(LoggingLevel.INFO, message: "24 hou time detected")
                dateFormatter.dateFormat = gDateTimeFormat24
            }
            else{
                dateFormatter.dateFormat = gDateTimeFormat
            }

            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")

            endDate = dateFormatter.dateFromString(gObjShowEventBean.event_end)!
            
            startDateAndTime = dateFormatter.dateFromString(gObjShowEventBean.event_start)!
           
            if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
                RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH){
                
                
                if (startDateAndTime.timeIntervalSinceReferenceDate < currentDate.timeIntervalSinceReferenceDate) {
                    self.editEvent.hidden = true
                    self.cancelEvent.hidden = true
                    self.claim.hidden = true
                    self.cancelClaim.hidden = true
                    self.tableView.hidden = true
                    
                }
                else if (gObjShowEventBean.active == false)
                {
                    self.editEvent.hidden = true
                    self.cancelEvent.hidden = true
                    self.claim.hidden = true
                    self.cancelClaim.hidden = true
                    self.tableView.hidden = true
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

            }else{
                
                if (startDateAndTime.timeIntervalSinceReferenceDate < currentDate.timeIntervalSinceReferenceDate) {
                    self.editEvent.hidden = true
                    self.cancelEvent.hidden = true
                    self.claim.hidden = true
                    self.cancelClaim.hidden = true
                    self.tableView.hidden = true
                    
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
           
            
        }
//        } else if(gBtnRadioValue == users) {
//            
//            self.labeltext1.text = "Role:"
//            self.labelText2.text = "Biography:"
//            self.labelText3.hidden = true
//            self.labelText4.hidden = true
//            self.labelText5.hidden = true
//            self.labelText6.hidden = true
//            
//            if(gObjSearchUserListBean.name != nil){
//                self.txtTitle.text = gObjSearchUserListBean.name
//            }
//           // self.txtText1.text = gObjSearchUserListBean.role
//            if(gObjSearchUserListBean.biography != nil){
//
//                self.txtText2.text = gObjSearchUserListBean.biography
//            }
//        }
        
        
        
//        overlay = UIView(frame: view.frame)
//        overlay!.backgroundColor = UIColor.blackColor()
//        overlay!.alpha = 0.8
        
//        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
//        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
//        activityIndicator.center = CGPointMake(overlay!.bounds.width / 2, overlay!.bounds.height / 2)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.CLAIM_LIST)
        
       
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
          
        
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
         //cell.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        if(gObjUserBean.id == gObjShowEventBean.user_id){
           
            if(claimBeanArray?.count > 0 &&  gSpeakerId == 0 &&
                (RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
                    RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH)){
                
                if (gObjShowEventBean.active == true && startDateAndTime.timeIntervalSinceReferenceDate > currentDate.timeIntervalSinceReferenceDate){
                    
                   
                
                    self.labelClaims.hidden = false
                    self.tableView.hidden  = false
            
                    var claimDisplayBean: ClaimListClaimBeanBean! = claimBeanArray![indexPath.row]
                      
                    gClaimUserName = claimDisplayBean.user_name
                    gClaimUser_id = claimDisplayBean.user_id
                    
                    (cell as! EventShowControllerCells).claimUserName!.text = String(claimDisplayBean.user_name)
                    (cell as! EventShowControllerCells).userId!.text =  String(claimDisplayBean.event_id)
                }
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
        
        if(currentCell.userId.text != nil){
            gClaimDetailId = Int(currentCell.userId.text!)
            gUserId = Int(currentCell.userId.text!)
        }
        if(currentCell.claimUserName.text != nil){
            gClaimSpeakerName = String(currentCell.claimUserName.text!)
        }
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.CLAIM_LIST_DETAILS)
           
        self.tableView.hidden = true
//        self.mainLabelJobTitle.hidden = false
//        self.mainLabelBusiness.hidden = false
//        self.labelUserName.hidden = false
//        self.labelBusiness.hidden = false
//        self.labelJobTitle.hidden = false
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
        
        self.labelUserName.hidden = true
        self.labelBusiness.hidden = true
        self.labelJobTitle.hidden = true
        self.mainLabelJobTitle.hidden = true
        self.mainLabelBusiness.hidden = true
        self.btnMessage.hidden = true
        self.btnAccept.hidden = true
        self.btnReject.hidden = true
        //showOverlay(self.view)
        tempBackToViewController = gObjBackTocontroller
        gObjBackTocontroller = gObjEventShowController
        gUserProfileMessage = false
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
        self.tableView.hidden = true
        
        self.btnMessage.hidden = true
        self.btnAccept.hidden = true
        self.btnReject.hidden = true
        self.editEvent.hidden = false
        self.cancelEvent.hidden = false
        
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
        
        self.btnMessage.hidden = true
        self.btnAccept.hidden = true
        self.btnReject.hidden = true
        self.editEvent.hidden = false
        self.cancelEvent.hidden = false
       
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
   
       // showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.CANCEL_CLAIM)
    }
    
    func alertActionOk(){
    
    
    }
    @IBAction func btnDeleteEvent(sender: AnyObject) {
        
        
        var refreshAlert = UIAlertController(title: "Alert", message: "Are you confirm delete the event.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Ok Action")
            self.showOverlay(self.view)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.CANCEL_EVENT)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Cancvel action")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)

        
    }
    @IBAction func btnSpeaker(sender: AnyObject) {
         gUserVIewBadgeId  = gSpeakerId
        if(gObjShowEventBean.speaker != "TBA" && gObjShowEventBean.speaker != nil){
            showOverlay(self.view)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_USER_PROFILE)
        }
    }
    @IBAction func btnSchoolProfile(sender: AnyObject) {
   
     //     ||
        if(gObjShowEventBean.loc_id != 1 ){
            showOverlay(self.view)
        
            gSchoolNameSelect = false
            gSchoolId = gObjShowEventBean.loc_id
       
            //gObjBackTocontroller = gObjEventShowController
        
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_SCHOOL_PROFILE)
        }
        else{
            self.searchBar.hidden = false
            navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItems = [menuButton,searchButton]
            searchBar.sizeToFit()
            searchBar.becomeFirstResponder()
            searchBar.showsCancelButton = true
            segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
            segmentSearchItems.selectedSegmentIndex = 1
            
            //navigationBar.items = [navigationItem]
            searchView.hidden = false
            
            
            gBtnRadioValue = "schools"

        }

    }
    @IBAction func btnUserProfile(sender: AnyObject) {
   
        gUserVIewBadgeId = gObjShowEventBean.user_id
        //gObjBackTocontroller = gObjEventShowController
        showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SHOW_USER_PROFILE)

    }
    
}