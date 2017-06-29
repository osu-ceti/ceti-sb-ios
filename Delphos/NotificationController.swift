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
    
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
          print(notificationArray.count)
          return notificationArray.count
        
        
    }
    
    func configureCell(_ cell: UITableViewCell,   indexPath: IndexPath)  {
        
      
        
         var notificationDisplayBean: NotificationListBean! = notificationArray[(indexPath as NSIndexPath).row]
        
        if(gNotificationCount != nil && notificationDisplayBean.read != nil){
            if(notificationDisplayBean.read == false){
                cell.backgroundColor = UIColor(hue: 0.5583, saturation: 0.25, brightness: 0.97, alpha: 1.0)
            }
        }
        else{
            cell.backgroundColor = UIColor.white
            
        }
         (cell as! NotificationControllerCell).actUSerName!.text = String(notificationDisplayBean.act_user_name)
        
        (cell as! NotificationControllerCell).eventId!.text = String(notificationDisplayBean.event_id)
        (cell as! NotificationControllerCell).UserNotificationType!.text = String(notificationDisplayBean.n_type)
       
        (cell as! NotificationControllerCell).id!.text = String(notificationDisplayBean.id)
        
        
        gNotificationNType = NOTIFICATION_TYPE(rawValue:notificationDisplayBean.n_type)!
        actUserId = Int(notificationDisplayBean.act_user_id)
        
        switch  gNotificationNType {
        
        case .claim :
           
            // claim
             (cell as! NotificationControllerCell).eventName!.text = "has claimed your event: "  + String(notificationDisplayBean.event_title)
             (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
              (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            
            break
            
        case NOTIFICATION_TYPE.confirm_SPEAKER :
            
            //confrim speaker
            (cell as! NotificationControllerCell).eventName!.text = "has confirmed you as the speaker of event: "  + String(notificationDisplayBean.event_title)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
            
        case NOTIFICATION_TYPE.event_UPDATE :
            
            //event update
            
            (cell as! NotificationControllerCell).eventName!.text = "has updated event: "  + String(notificationDisplayBean.event_title)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.message :
           
            //message
           
            
            (cell as! NotificationControllerCell).eventName!.text = "has sent you a message via email."
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            
            break
        case NOTIFICATION_TYPE.award_BADGE :
            
            //award_badge
            
            (cell as! NotificationControllerCell).eventName!.text = "Award them a badge."
             eventNametext = notificationDisplayBean.event_title
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            (cell as! NotificationControllerCell).speakerId!.text = String(notificationDisplayBean.act_user_id)
            
            break
        case NOTIFICATION_TYPE.new_BADGE :
            
            //new_badge
            
            (cell as! NotificationControllerCell).eventName!.text = "has awarded you a badge!"
            //String(notificationDisplayBean.act_user_name) +
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.cancel :
            
            //cancel
            
            (cell as! NotificationControllerCell).eventName!.text = String(notificationDisplayBean.act_user_name) + " has canceled the event:  "
                //+ String(notificationDisplayBean.event_title)
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.reject_CLAIM :
            
            //reject_claim
            
            (cell as! NotificationControllerCell).eventName!.text = " has chosen a different candidate"
            //String(notificationDisplayBean.act_user_name)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.cancel_CLAIM :
           
            //cancel_claim
           
            (cell as! NotificationControllerCell).eventName!.text =  String(notificationDisplayBean.act_user_name) + " has canceled their claim"
            //for event: " +  String(notificationDisplayBean.event_title)
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        case NOTIFICATION_TYPE.cancel_SPEAKER :
            
            //cancel_speaker
            
            (cell as! NotificationControllerCell).eventName!.text = String(notificationDisplayBean.act_user_name) + " has to cancel their speaking engagement "
            //for event:" + String(notificationDisplayBean.event_title)
           (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        default :
           
            (cell as! NotificationControllerCell).eventName!.text = DelphosStrings.EMPTY_STRING  + String(notificationDisplayBean.event_title)
            (cell as! NotificationControllerCell).hiddenEventName!.text = notificationDisplayBean.event_title
            (cell as! NotificationControllerCell).hiddenNType!.text = String(notificationDisplayBean.n_type)
            break
        }
    }
    
    //function to return dynamic cell
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationId", for: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        var selectCell = tableView.cellForRow(at: indexPath) as! NotificationControllerCell
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
       
       
        gNotificationNType = NOTIFICATION_TYPE(rawValue:Int(selectCell.UserNotificationType.text!)!)!
        
       
        
       // dispatch_async(dispatch_get_main_queue(), {
             //gObjBackTocontroller = gObjNotificationControllerNav
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.read_NOTIFICATION)
       // })
        
        
        gObjBackTocontroller = gObjNotificationControllerNav
        
        switch gNotificationNType {

            
            case NOTIFICATION_TYPE.award_BADGE :
                
                //award_badge
                
               //gActUserId = Int(selectCell.id.text!)
               // dispatch_async(dispatch_get_main_queue(), {
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.view_BADGE_AWARD)
              //  })
            break
            
            case NOTIFICATION_TYPE.new_BADGE :
            
            //new_badge
              //  dispatch_async(dispatch_get_main_queue(), {
                    
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    let testfacade = appDelegate.getObjFacade()
//                    testfacade.doTask(self,action: DelphosAction.show_EVENT)
                
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.SHOW_AWARDED_BADGE)
               // })
            
            break
            case NOTIFICATION_TYPE.message :
                
            break
            default :
               
              

                //dispatch_async(dispatch_get_main_queue(), {
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.show_EVENT)
                //})
           
            
            break
          
        }

        
        
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //print("Scroll finished")
        notificationPage += 1
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            print("Scroll bottom")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
                    testfacade.doTask(self,action: DelphosAction.show_NOTIFICATION)
            

    
        }
        
    }
    @IBAction func btnMarkAllNOtificationClick(_ sender: AnyObject) {
   
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.mark_ALL_NOTIFICATION)
        

        
    }
    
}
