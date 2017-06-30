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
   
    var claimListCount: Int = 0
    var schoolProfileId:Int!
   
    var claimBeanArray: [ClaimListClaimBeanBean]? = []
    var speakerNameArr: [SpeakerBean]? = []
   // var acceptClaimBeanDetails: ShowEventBean?
   
    var name = ["claim"]
    var selectedClaimId:Int = 0
    var selectedEventId:Int = 0
    var currentDate = Date()
   
    var dateFormatter = DateFormatter()
    var minusCurrentDate = Date()
    var endDate = Date()
    var startDateAndTime = Date()
    
    var tempBackToViewController: UIViewController!
    var strSpeakerName:String = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       if(tempBackToViewController != nil){
            gObjBackTocontroller = tempBackToViewController
            tempBackToViewController = nil
            self.isBackEnabled = true
        }
       else{
           gObjBackTocontroller = gObjHomeController
        }
        
        self.hideOverlayView()
       
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        
            //Adding Navbar
//        menus = regularMenu
//        rightViewController.isRegister = false
//        rightViewController.tableView.reloadData()
        
       
        
       // backToController = gObjHomeController
    
    
    
    
        

        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        rootViewController = self
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.cancelClaim.frame.origin.y + 250)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelClaims.isHidden = true
        self.labelUserName.isHidden = true
        self.mainLabelBusiness.isHidden = true
        self.mainLabelJobTitle.isHidden = true
        self.labelBusiness.isHidden = true
        self.labelJobTitle.isHidden = true
        self.tableView.isHidden = true
        
        self.btnMessage.isHidden = true
        self.btnAccept.isHidden = true
        self.btnReject.isHidden = true
        
        self.editEvent.isHidden = true
        self.cancelEvent.isHidden = true
        self.claim.isHidden = true
        self.cancelClaim.isHidden = true
        
        self.view.backgroundColor = bgColor
        
        self.tableView.backgroundColor = bgColor
        self.tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        
//        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gDateTimeFormat
        
        txtTitle.font = UIFont.boldSystemFont(ofSize: 15)
        labeltext1.font = UIFont.boldSystemFont(ofSize: 15)
        labelText2.font = UIFont.boldSystemFont(ofSize: 15)
        labelText3.font = UIFont.boldSystemFont(ofSize: 15)
        labelText4.font = UIFont.boldSystemFont(ofSize: 15)
        labelText5.font = UIFont.boldSystemFont(ofSize: 15)
        labelText6.font = UIFont.boldSystemFont(ofSize: 15)
    
        
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
                
                //strSpeakerName
                speakerNameArr = gObjShowEventBean.speaker
                var count : Int = 0
                if((speakerNameArr?.count)! > 2){
                    count = 2
                }else{
                    count = (speakerNameArr?.count)!
                }
                
                for index in 0 ..< (count) {
                  strSpeakerName = strSpeakerName + (speakerNameArr?[index].name)! + ", "
                }
              
                
                if((speakerNameArr?.count)! > 2){
                    strSpeakerName = strSpeakerName + "more"
                }else{
                    let endIndexSpeakerName = strSpeakerName.index(strSpeakerName.endIndex, offsetBy:-2)
                    strSpeakerName = strSpeakerName.substring(to:endIndexSpeakerName)
                }
                
                 gSpeakerName =  String(describing: strSpeakerName)
                 btnLinkSpeaker.setTitle( gSpeakerName, for: UIControlState())
                
            }
            else{
                gSpeakerName =  "TBA"
                btnLinkSpeaker.setTitle( gSpeakerName, for: UIControlState())

            }
            
            btnLinkLocation.setTitle(gObjShowEventBean.loc_name, for: UIControlState())
            btnLinkCreatedBy.setTitle(gObjShowEventBean.user_name, for: UIControlState())
            
            if (gObjShowEventBean.active == false)
            {
                var titleLength = gObjShowEventBean.title.characters.count
                var attributedString = NSMutableAttributedString(string: gObjShowEventBean.title as String)
                let secondAttributes = [NSForegroundColorAttributeName: UIColor.red,  NSStrikethroughStyleAttributeName: 1] as [String : Any]
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
            minusCurrentDate = currentDate.addingTimeInterval(-1*24*60*60);

            print("End Date = " + gObjShowEventBean.event_end)
            
            if(!gObjShowEventBean.event_end.contains("AM") && !gObjShowEventBean.event_end.contains("PM")){
                logger.log(LoggingLevel.INFO, message: "24 hou time detected")
                dateFormatter.dateFormat = gDateTimeFormat24
            }
            else{
                dateFormatter.dateFormat = gDateTimeFormat
            }
           
            dateFormatter.timeZone = TimeZone(abbreviation: getTimeZone(from: gObjShowEventBean.event_end!))

            dateFormatter.locale = Locale(identifier: "en_US_POSIX")

            endDate = dateFormatter.date(from: gObjShowEventBean.event_end)!
            
            startDateAndTime = dateFormatter.date(from: gObjShowEventBean.event_start)!
           
            if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.teacher ||
                RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.both){
                
                
                if (startDateAndTime.timeIntervalSinceReferenceDate < currentDate.timeIntervalSinceReferenceDate) {
                    self.editEvent.isHidden = true
                    self.cancelEvent.isHidden = true
                    self.claim.isHidden = true
                    self.cancelClaim.isHidden = true
                    self.tableView.isHidden = true
                    
                }
                else if (gObjShowEventBean.active == false)
                {
                    self.editEvent.isHidden = true
                    self.cancelEvent.isHidden = true
                    self.claim.isHidden = true
                    self.cancelClaim.isHidden = true
                    self.tableView.isHidden = true
                }
                else if(gObjUserBean.id == gObjShowEventBean.user_id){
                    self.editEvent.isHidden = false
                    self.cancelEvent.isHidden = false
                    self.claim.isHidden = true
                    self.cancelClaim.isHidden = true
                   
                    
                    gCancelEvent = "cancelEvent "
                    gEditEvent = "EditEvent"
                    cancelEvent.setTitle( "Cancel Event", for: UIControlState())
                    editEvent.setTitle( "Edit Event", for: UIControlState())
                    //gEditEvent.frame = CGRectMake
                }
                else{
                    self.editEvent.isHidden = true
                    self.cancelEvent.isHidden = true
                    self.claim.isHidden = false
                    self.cancelClaim.isHidden = true
                }

            }else{
                
                if (startDateAndTime.timeIntervalSinceReferenceDate < currentDate.timeIntervalSinceReferenceDate) {
                    self.editEvent.isHidden = true
                    self.cancelEvent.isHidden = true
                    self.claim.isHidden = true
                    self.cancelClaim.isHidden = true
                    self.tableView.isHidden = true
                    
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
//        DispatchQueue.main.async(execute: {
//            self.hideOverlayView()
//            
//        })
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.claim_LIST)
        
       // claimListCount = (claimBeanArray?.count)!
        
       
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return claimListCount
          
        
    }
    
    func configureCell(_ cell: UITableViewCell,   indexPath: IndexPath)  {
         //cell.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        if(gObjUserBean.id == gObjShowEventBean.user_id){
           
            if((claimBeanArray?.count)! > 0 &&  gSpeakerId == 0 &&
                (RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.teacher ||
                    RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.both)){
                
                if (gObjShowEventBean.active == true && startDateAndTime.timeIntervalSinceReferenceDate > currentDate.timeIntervalSinceReferenceDate){
                    
                     var claimDisplayBean: ClaimListClaimBeanBean! = claimBeanArray![(indexPath as NSIndexPath).row]
                
                    if(claimDisplayBean.claim_rejected == false
                        && claimDisplayBean.confirmed_by_teacher == false ){
                        self.labelClaims.isHidden = false
                        self.tableView.isHidden  = false
                        
                        
                        
                        gClaimUserName = claimDisplayBean.user_name
                        gClaimUser_id = claimDisplayBean.user_id
                        
                        (cell as! EventShowControllerCells).claimUserName!.text = String(claimDisplayBean.user_name)
                        (cell as! EventShowControllerCells).userId!.text =  String(claimDisplayBean.event_id)
                        (cell as! EventShowControllerCells).claimId!.text =  String(claimDisplayBean.claim_id)
                    }
                    
                }
            }
        }
        else{
            self.tableView.isHidden = true
        
        }
        
    }
    
    //function to return dynamic cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimCell", for: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! EventShowControllerCells
        print("currentCell", currentCell.userId.text!)
        
        if(currentCell.userId.text != nil){
            gClaimDetailId = Int(currentCell.claimId.text!)
            gUserId = Int(currentCell.userId.text!)
        }
        if(currentCell.claimUserName.text != nil){
            gClaimSpeakerName = String(currentCell.claimUserName.text!)
        }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.claim_LIST_DETAILS)
           
        self.tableView.isHidden = true
//        self.mainLabelJobTitle.hidden = false
//        self.mainLabelBusiness.hidden = false
//        self.labelUserName.hidden = false
//        self.labelBusiness.hidden = false
//        self.labelJobTitle.hidden = false
        self.editEvent.isHidden = true
        self.cancelEvent.isHidden = true
       
        self.claim.isHidden = true
        self.cancelClaim.isHidden = true
        if(gObjUserBean.id == gObjShowEventBean.user_id){
            self.btnMessage.isHidden = false
            self.btnAccept.isHidden = false
            self.btnReject.isHidden = false
        }
        else{
            self.btnMessage.isHidden = true
            self.btnAccept.isHidden = true
            self.btnReject.isHidden = true
        
        }
        
    }

    @IBAction func btnSendMessage(_ sender: AnyObject) {
        
        self.labelUserName.isHidden = true
        self.labelBusiness.isHidden = true
        self.labelJobTitle.isHidden = true
        self.mainLabelJobTitle.isHidden = true
        self.mainLabelBusiness.isHidden = true
        self.btnMessage.isHidden = true
        self.btnAccept.isHidden = true
        self.btnReject.isHidden = true
        //showOverlay(self.view)
        self.tableView.isHidden = false
        tempBackToViewController = gObjBackTocontroller
        gObjBackTocontroller = gObjEventShowController
        gUserProfileMessage = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.view_MESSAGE_CONTROLLER)
       
        
    }
    @IBAction func btnTouchAccept(_ sender: AnyObject) {
        
        //showOverlay(self.view)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.claim_ACCEPT)
         // var claimAcceptDisplayBean: ShowEventBean! = acceptClaimBeanArray![1]
        
        
       

        self.labelUserName.isHidden = true
        self.mainLabelBusiness.isHidden = true
        self.mainLabelJobTitle.isHidden = true
        self.labelBusiness.isHidden = true
        self.labelJobTitle.isHidden = true
        self.tableView.isHidden = false
        
        self.btnMessage.isHidden = true
        self.btnAccept.isHidden = true
        self.btnReject.isHidden = true
        self.editEvent.isHidden = false
        self.cancelEvent.isHidden = false
        
    }
    
    
    @IBAction func btnTouchReject(_ sender: AnyObject) {
        
      // showOverlay(self.view)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.claim_REJECT)
        
        
        self.labelUserName.isHidden = true
        self.mainLabelBusiness.isHidden = true
        self.mainLabelJobTitle.isHidden = true
        self.labelBusiness.isHidden = true
        self.labelJobTitle.isHidden = true
       self.tableView.isHidden = false
        
        self.btnMessage.isHidden = true
        self.btnAccept.isHidden = true
        self.btnReject.isHidden = true
        self.editEvent.isHidden = false
        self.cancelEvent.isHidden = false
       
    }
    
    
    
    @IBAction func btnEditEvent(_ sender: AnyObject) {
        showOverlay(self.view)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.edit_EVENT_SHOW)

        

    }
    @IBAction func btnClaim(_ sender: AnyObject) {
        
       showOverlay(self.view)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.claim_EVENT)
        
       
    }
    
    @IBAction func btnCancelClaim(_ sender: AnyObject) {
   
       // showOverlay(self.view)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.cancel_CLAIM)
    }
    
    func alertActionOk(){
    
    
    }
    @IBAction func btnDeleteEvent(_ sender: AnyObject) {
        
        
        var refreshAlert = UIAlertController(title: "Alert", message: "Are you confirm delete the event.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Ok Action")
            self.showOverlay(self.view)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.cancel_EVENT)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancvel action")
        }))
        
        present(refreshAlert, animated: true, completion: nil)

        
    }
    @IBAction func btnSpeaker(_ sender: AnyObject) {
        
        if(gObjShowEventBean.speaker != nil){
           
            gUserVIewBadgeId  = gSpeakerId
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_USER_PROFILE_LIST)
        }
//        if(gObjShowEventBean.speaker != nil){
//            showOverlay(self.view)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let testfacade = appDelegate.getObjFacade()
//            testfacade.doTask(self,action: DelphosAction.show_USER_PROFILE)
//        }
    }
    @IBAction func btnSchoolProfile(_ sender: AnyObject) {
   
     //     ||
        if(gObjShowEventBean.loc_id != 1 ){
            showOverlay(self.view)
        
            gSchoolNameSelect = false
            gSchoolId = gObjShowEventBean.loc_id
       
            //gObjBackTocontroller = gObjEventShowController
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.show_SCHOOL_PROFILE)
        }
        else{
            self.searchBar.isHidden = true
            //navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItems = [menuButton,searchButton]
            searchBar.sizeToFit()
            searchBar.becomeFirstResponder()
            searchBar.showsCancelButton = true
            segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
            segmentSearchItems.selectedSegmentIndex = 1
            
            //navigationBar.items = [navigationItem]
            searchView.isHidden = false
            
            
            gBtnRadioValue = "schools"

        }

    }
    @IBAction func btnUserProfile(_ sender: AnyObject) {
   
        gUserVIewBadgeId = gObjShowEventBean.user_id
        //gObjBackTocontroller = gObjEventShowController
        showOverlay(self.view)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.show_USER_PROFILE)

    }
    
}
