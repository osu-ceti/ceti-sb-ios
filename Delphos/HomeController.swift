//
//  EventDisplay.swift
//  Delphos
//
//  Created by Prabhu on 5/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit


class HomeController:  NavController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var btnConfirmEvent: UIButton!
    @IBOutlet weak var btnClaimEvent: UIButton!
    @IBOutlet weak var btnApprovalEvent: UIButton!
    @IBOutlet weak var btnAllEvent: UIButton!
    @IBOutlet weak var btnCreateEvent: UIButton!
   
     var bottomLineAll      = CALayer()
     var bottomLineApproval = CALayer()
     var bottomLineClaim    = CALayer()
     var bottomLineConfirm  = CALayer()
    
    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var eventBeanSearchArray: [EventBean]! = []
   
    var listType = EventListingType.ALL
    
    @IBOutlet weak var tableView: UITableView!
   // var radioButtonController: SSRadioButtonsController?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        menus = regularMenu
        rightViewController.isRegister = false
        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = false
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.title = "School-Business"
        
//
     //   radioButtonController!.delegate = self

        
        self.tableView.dataSource = self
        tableView.delegate = self
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
        
        self.tableView.tableFooterView = UIView()
        gBtnRadioValue = "events"
       
        //self.setNavigationBarItem()
        if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.TEACHER ||
            RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.BOTH){
            self.btnCreateEvent.hidden = false
        }
        else{
            self.btnCreateEvent.hidden = true
        }
              
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 10), false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(context, 10, 50)
        CGContextAddLineToPoint(context, 20, 100)
        
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextStrokePath(context)
        

        
    }
    
    
    @IBAction func btnCreateEvent(sender: UIButton) {
        if(gObjCreateEventController == nil){
            gObjCreateEventController = fetchNavController(gStrCreateEventControllerID)
        }
        self.slideMenuController()?.changeMainViewController(gObjCreateEventController, close: false)
//
//        let goToCreateEvent = self.storyboard?.instantiateViewControllerWithIdentifier("CreateEventId") as! CreateEventController
//        self.presentViewController(goToCreateEvent, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
  
  


    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }

    func btnAdd(sender:UIButton) {
        print("clicked")
    }

    
   
    func getEventsList(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
    }
   
    @IBAction func eventAll(sender: UIButton) {
       listType = EventListingType.ALL
       getEventsList()
 
        bottomLineAll.frame = CGRectMake(0, btnAllEvent.frame.size.height - 1.0, btnAllEvent.frame.size.width, 1)
        bottomLineAll.borderWidth = 2.0
        bottomLineAll.borderColor = UIColor.blueColor().CGColor
        btnAllEvent.layer.addSublayer(bottomLineAll)
       
       
        bottomLineApproval.borderColor = UIColor.clearColor().CGColor
        bottomLineClaim.borderColor = UIColor.clearColor().CGColor
        bottomLineConfirm.borderColor = UIColor.clearColor().CGColor
       
    }
    @IBAction func eventApproval(sender: AnyObject) {
        listType = EventListingType.APPROVED
        getEventsList()
        
        bottomLineApproval.frame = CGRectMake(0, btnApprovalEvent.frame.size.height - 1.0, btnApprovalEvent.frame.size.width, 1)
        bottomLineApproval.borderWidth = 2.0
        bottomLineApproval.borderColor = UIColor.blueColor().CGColor
        btnApprovalEvent.layer.addSublayer(bottomLineApproval)
       
        bottomLineClaim.borderColor = UIColor.clearColor().CGColor
        bottomLineAll.borderColor = UIColor.clearColor().CGColor
        bottomLineConfirm.borderColor = UIColor.clearColor().CGColor
       
    }
    @IBAction func eventClaims(sender: AnyObject) {
        listType = EventListingType.CLAIMS
        getEventsList()
        
        bottomLineClaim.frame = CGRectMake(0, btnClaimEvent.frame.size.height - 1.0, btnClaimEvent.frame.size.width, 1)
        bottomLineClaim.borderWidth = 2.0
        bottomLineClaim.borderColor = UIColor.blueColor().CGColor
        btnClaimEvent.layer.addSublayer(bottomLineClaim)
        
        bottomLineAll.borderColor = UIColor.clearColor().CGColor
        bottomLineApproval.borderColor = UIColor.clearColor().CGColor
        bottomLineConfirm.borderColor = UIColor.clearColor().CGColor
       
    }
    @IBAction func eventConfirmed(sender: AnyObject) {
        listType = EventListingType.CONFIRMED
        getEventsList()
        
        bottomLineConfirm.frame = CGRectMake(0, btnConfirmEvent.frame.size.height - 1.0, btnConfirmEvent.frame.size.width, 1)
        bottomLineConfirm.borderWidth = 2.0
        bottomLineConfirm.borderColor = UIColor.blueColor().CGColor
        btnConfirmEvent.layer.addSublayer(bottomLineConfirm)
        
        bottomLineAll.borderColor = UIColor.clearColor().CGColor
        bottomLineApproval.borderColor = UIColor.clearColor().CGColor
        bottomLineClaim.borderColor = UIColor.clearColor().CGColor
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
       return eventBeanArray.count
        
    }
    
     func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
       
         var eventDisplayBean: EventBean! = eventBeanArray[indexPath.row]
        
      (cell as! EventDisplayCell).eventName!.text = String(eventDisplayBean.event_title)
      (cell as! EventDisplayCell).eventStartDate!.text = String(eventDisplayBean.event_start)
      (cell as! EventDisplayCell).eventID!.text = String(eventDisplayBean.id)
        
     }
    
    //function to return dynamic cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeID", forIndexPath: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! EventDisplayCell
        print("currentCell", currentCell.eventID.text!)
        
       gEventID = Int(currentCell.eventID.text!)
        dispatch_async(dispatch_get_main_queue(), {

            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_EVENT)
        })
    }
    
}