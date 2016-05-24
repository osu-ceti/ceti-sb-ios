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
//    @IBOutlet weak var btnClaimEvent: UIButton!
//    @IBOutlet weak var btnConfirmEvent: UIButton!
    @IBOutlet weak var btnCreateEvent: UIButton!
    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var eventBeanSearchArray: [EventBean]! = []
   
    var listType = EventListingType.ALL
    
    @IBOutlet weak var tableView: UITableView!
   // var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Navbar
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        navigationBar.delegate = self;
        backToView = ""
        radioButtonController!.delegate = self

        
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
        
    }
    
   
    
    @IBAction func btnCreateEvent(sender: UIButton) {
    
        let goToCreateEvent = self.storyboard?.instantiateViewControllerWithIdentifier("CreateEventId") as! CreateEventController
        self.presentViewController(goToCreateEvent, animated: true, completion: nil)
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
       
        btnAllEvent.backgroundColor = UIColor.blueColor()
        
        btnApprovalEvent.backgroundColor = UIColor.clearColor()
        btnClaimEvent.backgroundColor = UIColor.clearColor()
        btnConfirmEvent.backgroundColor = UIColor.clearColor()
    }
    @IBAction func eventApproval(sender: AnyObject) {
        listType = EventListingType.APPROVED
        getEventsList()
        btnApprovalEvent.backgroundColor = UIColor.blueColor()
        btnAllEvent.backgroundColor = UIColor.clearColor()
        btnClaimEvent.backgroundColor = UIColor.clearColor()
        btnConfirmEvent.backgroundColor = UIColor.clearColor()

    }
    @IBAction func eventClaims(sender: AnyObject) {
        listType = EventListingType.CLAIMS
        getEventsList()
        btnClaimEvent.backgroundColor = UIColor.blueColor()
        btnApprovalEvent.backgroundColor = UIColor.clearColor()
        btnAllEvent.backgroundColor = UIColor.clearColor()
        btnConfirmEvent.backgroundColor = UIColor.clearColor()
    }
    @IBAction func eventConfirmed(sender: AnyObject) {
        listType = EventListingType.CONFIRMED
        getEventsList()
        btnConfirmEvent.backgroundColor = UIColor.blueColor()
        btnApprovalEvent.backgroundColor = UIColor.clearColor()
        btnClaimEvent.backgroundColor = UIColor.clearColor()
        btnAllEvent.backgroundColor = UIColor.clearColor()
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