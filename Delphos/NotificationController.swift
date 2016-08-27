//
//  NotificationController.swift
//  Delphos
//
//  Created by Babu on 7/2/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//



import UIKit
import ObjectMapper

class NotificationController: NavController {
    
   
    @IBOutlet var tableView: UITableView!
    
    var notificationDisplayBean: NotificationBean!
    var notificationArray: [NotificationListBean]! = []
    
    var actUserId:Int!
    var notificationId:Int!
    
    var eventNametext:String?
    var eventId:Int!
    
    
    
    @IBOutlet var btnMarkAllNotification: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        rootViewController = self
        self.isBackEnabled = false
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
       // backToController = gObjHomeController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Navbar
        //        setNavBar(self.view.frame.size.width)
        //        searchBar.delegate = self
        //        navigationBar.delegate = self;
        //        backToView = "HomeID"
        //
        
       
       //gObjBackTocontroller = gObjNotificationControllerNav
          //self.tableView.reloadData()
        self.view.backgroundColor = bgColor
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = bgColor
        //self.tableView.reloadData()
        
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
        
          print(notificationArray.count)
          return notificationArray.count
        
        
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
        
      
        
         var notificationDisplayBean: NotificationListBean! = notificationArray[indexPath.row]
        if(gNotificationCount != nil && notificationDisplayBean.read == 0){
            
            cell.backgroundColor = UIColor(hue: 0.5583, saturation: 0.25, brightness: 0.97, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor.whiteColor()
            
        }
         (cell as! NotificationControllerCell).actUSerName!.text = String(notificationDisplayBean.act_user_name)
        
        (cell as! NotificationControllerCell).eventId!.text = String(notificationDisplayBean.event_id)
        (cell as! NotificationControllerCell).UserNotificationType!.text = String(notificationDisplayBean.n_type)
       
        (cell as! NotificationControllerCell).id!.text = String(notificationDisplayBean.id)
        
        
        gNotificationNType = notificationDisplayBean.n_type
        actUserId = Int(notificationDisplayBean.act_user_id)
        
        switch gNotificationNType {
        
        case NOTIFICATION_TYPE.CLAIM.rawValue :
           
            // claim
             (cell as! NotificationControllerCell).eventName!.text = "has claimed your event: "  + String(notificationDisplayBean.event_title)
             (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
              (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            
            break
            
        case NOTIFICATION_TYPE.CONFIRM_SPEAKER.rawValue :
            
            //confrim speaker
            (cell as! NotificationControllerCell).eventName!.text = "has confirmed you as the speaker of event: "  + String(notificationDisplayBean.event_title)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
            
        case NOTIFICATION_TYPE.EVENT_UPDATE.rawValue :
            
            //event update
            
            (cell as! NotificationControllerCell).eventName!.text = "has updated event: "  + String(notificationDisplayBean.event_title)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.MESSAGE.rawValue :
           
            //message
           
            
            (cell as! NotificationControllerCell).eventName!.text = "has sent you a message via email."
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            
            break
        case NOTIFICATION_TYPE.AWARD_BADGE.rawValue :
            
            //award_badge
            
            (cell as! NotificationControllerCell).eventName!.text = "Award them a badge."
             eventNametext = notificationDisplayBean.event_title
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.NEW_BADGE.rawValue :
            
            //new_badge
            
            (cell as! NotificationControllerCell).eventName!.text = "has awarded you a badge!"
            //String(notificationDisplayBean.act_user_name) +
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.CANCEL.rawValue :
            
            //cancel
            
            (cell as! NotificationControllerCell).eventName!.text = String(notificationDisplayBean.act_user_name) + " has canceled the event:  "
                //+ String(notificationDisplayBean.event_title)
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.REJECT_CLAIM.rawValue :
            
            //reject_claim
            
            (cell as! NotificationControllerCell).eventName!.text = " has chosen a different candidate"
            //String(notificationDisplayBean.act_user_name)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.CANCEL_CLAIM.rawValue :
           
            //cancel_claim
           
            (cell as! NotificationControllerCell).eventName!.text =  String(notificationDisplayBean.act_user_name) + " has canceled their claim"
            //for event: " +  String(notificationDisplayBean.event_title)
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.CANCEL_SPEAKER.rawValue :
            
            //cancel_speaker
            
            (cell as! NotificationControllerCell).eventName!.text = String(notificationDisplayBean.act_user_name) + " has to cancel their speaking engagement "
            //for event:" + String(notificationDisplayBean.event_title)
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        default :
           
            (cell as! NotificationControllerCell).eventName!.text = ""  + String(notificationDisplayBean.event_title)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        }
    }
    
    //function to return dynamic cell
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NotificationId", forIndexPath: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectCell = tableView.cellForRowAtIndexPath(indexPath) as! NotificationControllerCell
        print("currentCell", selectCell.eventId.text!)
        
        gEventID = Int(selectCell.eventId.text!)
        eventId = Int(selectCell.eventId.text!)
        notificationId = Int(selectCell.id.text!)
        
       
        gActUserName = selectCell.actUSerName.text
        gAwardNtype = Int(selectCell.hiddenNType.text!)
      
        if(selectCell.hiddenEventName.text != nil){
            //gEventTitle = eventNametext
            gEventTitle = selectCell.hiddenEventName.text!
        }
       
       
        gNotificationNType = Int(selectCell.UserNotificationType.text!)
        
       
        
       // dispatch_async(dispatch_get_main_queue(), {
             //gObjBackTocontroller = gObjNotificationControllerNav
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.READ_NOTIFICATION)
       // })
        
        
        gObjBackTocontroller = gObjNotificationControllerNav
        
        switch gNotificationNType {

            
            case NOTIFICATION_TYPE.AWARD_BADGE.rawValue :
                
                //award_badge
                
                
               // dispatch_async(dispatch_get_main_queue(), {
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.VIEW_BADGE_AWARD)
              //  })
            break
            
            case NOTIFICATION_TYPE.NEW_BADGE.rawValue :
            
            //new_badge
              //  dispatch_async(dispatch_get_main_queue(), {
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.SHOW_EVENT)
               // })
            
            break
            
            default :
               
              

                //dispatch_async(dispatch_get_main_queue(), {
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.SHOW_EVENT)
                //})
           
            
            break
          
        }

        
        
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //print("Scroll finished")
        notificationPage += 1
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            print("Scroll bottom")
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.SHOW_NOTIFICATION)
            

    
        }
        
    }
    @IBAction func btnMarkAllNOtificationClick(sender: AnyObject) {
   
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.MARK_ALL_NOTIFICATION)
        
    }
    
}
