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
    @IBOutlet weak var noEventsFound: UILabel!
    
    var bottomLineAll      = CALayer()
    var bottomLineApproval = CALayer()
    var bottomLineClaim    = CALayer()
    var bottomLineConfirm  = CALayer()
    
    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var eventBeanSearchArray: [EventBean]! = []
   
    var listType = EventListingType.all
    
    @IBOutlet weak var tableView: UITableView!
   // var radioButtonController: SSRadioButtonsController?
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gObjBackTocontroller = gObjHomeController
        //Adding Navbar
        menus = regularMenu
        rightViewController.isRegister = false
        rightViewController.tableView.reloadData()
        navigationItem.title = "School-Business"
        self.isBackEnabled = false
        
       // self.gNotificationCount = "0"
        
        
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
       
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount,searchButton]
        navigationItem.title = "School-Business"
        searchBar.text = ""
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = false
        
        
        
        // navigationBar.items = [navigationItem]
        searchView.isHidden = true
         
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootViewController = self
        
        
      
        self.view.backgroundColor = bgColor
        self.tableView.backgroundColor = bgColor
        
       
        
        self.tableView.isHidden = true
        self.noEventsFound.isHidden = true
        
        self.tableView.dataSource = self
        tableView.delegate = self
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.event_ALL)
        
        self.tableView.tableFooterView = UIView()
        gBtnRadioValue = "events"
       
        //self.setNavigationBarItem()
        if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.teacher ||
            RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.both){
            self.btnCreateEvent.isHidden = false
        }
        else{
            self.btnCreateEvent.isHidden = true
        }
        
        bottomLineAll.frame = CGRect(x: 0, y: btnAllEvent.frame.size.height - 1.0, width: btnAllEvent.frame.size.width, height: 1)
        bottomLineAll.borderWidth = 2.0
        bottomLineAll.borderColor = UIColor(hue: 0.4528, saturation: 0.65, brightness: 0.63, alpha: 1.0).cgColor /* #38a083 */
        btnAllEvent.layer.addSublayer(bottomLineAll)

        
    }
    
    
    @IBAction func btnCreateEvent(_ sender: UIButton) {
       // if(gObjCreateEventController == nil){
            gObjCreateEventController = fetchNavController(gStrCreateEventControllerID)
        //}
        self.slideMenuController()?.changeMainViewController(gObjCreateEventController, close: false)
//
//        let goToCreateEvent = self.storyboard?.instantiateViewControllerWithIdentifier("CreateEventId") as! CreateEventController
//        self.presentViewController(goToCreateEvent, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
  
  

    
   
    func getEventsList(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.event_ALL)
    }
   
    @IBAction func eventAll(_ sender: UIButton) {
       listType = EventListingType.all
       getEventsList()
 
        bottomLineAll.frame = CGRect(x: 0, y: btnAllEvent.frame.size.height - 1.0, width: btnAllEvent.frame.size.width, height: 1)
        bottomLineAll.borderWidth = 2.0
        bottomLineAll.borderColor = UIColor(hue: 0.4528, saturation: 0.65, brightness: 0.63, alpha: 1.0).cgColor /* #38a083 */
        btnAllEvent.layer.addSublayer(bottomLineAll)
       
       
        bottomLineApproval.borderColor = UIColor.clear.cgColor
        bottomLineClaim.borderColor = UIColor.clear.cgColor
        bottomLineConfirm.borderColor = UIColor.clear.cgColor
       
    }
    @IBAction func eventApproval(_ sender: AnyObject) {
        listType = EventListingType.approved
        getEventsList()
        
        bottomLineApproval.frame = CGRect(x: 0, y: btnApprovalEvent.frame.size.height - 1.0, width: btnApprovalEvent.frame.size.width, height: 1)
        bottomLineApproval.borderWidth = 2.0
        bottomLineApproval.borderColor = UIColor(hue: 0.4528, saturation: 0.65, brightness: 0.63, alpha: 1.0).cgColor /* #38a083 */
        btnApprovalEvent.layer.addSublayer(bottomLineApproval)
       
        bottomLineClaim.borderColor = UIColor.clear.cgColor
        bottomLineAll.borderColor = UIColor.clear.cgColor
        bottomLineConfirm.borderColor = UIColor.clear.cgColor
       
    }
    @IBAction func eventClaims(_ sender: AnyObject) {
        listType = EventListingType.claims
        getEventsList()
        
        bottomLineClaim.frame = CGRect(x: 0, y: btnClaimEvent.frame.size.height - 1.0, width: btnClaimEvent.frame.size.width, height: 1)
        bottomLineClaim.borderWidth = 2.0
        bottomLineClaim.borderColor = UIColor(hue: 0.4528, saturation: 0.65, brightness: 0.63, alpha: 1.0).cgColor /* #38a083 */
        btnClaimEvent.layer.addSublayer(bottomLineClaim)
        
        bottomLineAll.borderColor = UIColor.clear.cgColor
        bottomLineApproval.borderColor = UIColor.clear.cgColor
        bottomLineConfirm.borderColor = UIColor.clear.cgColor
       
    }
    @IBAction func eventConfirmed(_ sender: AnyObject) {
        listType = EventListingType.confirmed
        getEventsList()
        
        bottomLineConfirm.frame = CGRect(x: 0, y: btnConfirmEvent.frame.size.height - 1.0, width: btnConfirmEvent.frame.size.width, height: 1)
        bottomLineConfirm.borderWidth = 2.0
        bottomLineConfirm.borderColor = UIColor(hue: 0.4528, saturation: 0.65, brightness: 0.63, alpha: 1.0).cgColor /* #38a083 */
        btnConfirmEvent.layer.addSublayer(bottomLineConfirm)
        
        bottomLineAll.borderColor = UIColor.clear.cgColor
        bottomLineApproval.borderColor = UIColor.clear.cgColor
        bottomLineClaim.borderColor = UIColor.clear.cgColor
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if(eventBeanArray.count > 0){
            return eventBeanArray.count
        }
        else{
            return 1
        }
    }
    
     func configureCell(_ cell: UITableViewCell,   indexPath: IndexPath)  {
       
        
        if(eventBeanArray.count > 0){
            self.tableView.isHidden = false
            self.noEventsFound.isHidden = true
            let eventDisplayBean: EventBean! = eventBeanArray[(indexPath as NSIndexPath).row]
            if(eventDisplayBean.event_title != nil){
                (cell as! EventDisplayCell).eventName!.text = String(eventDisplayBean.event_title)
            }
            if(eventDisplayBean.event_start != nil){

                (cell as! EventDisplayCell).eventStartDate!.text = String(eventDisplayBean.event_start)
            }
            if(eventDisplayBean.id != nil){

                (cell as! EventDisplayCell).eventID!.text = String(eventDisplayBean.id)
            }
        }
        else{
            self.tableView.isHidden = true
            self.noEventsFound.isHidden = false
        }
     }
    
    //function to return dynamic cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeID", for: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! EventDisplayCell
        print("currentCell", currentCell.eventID.text!)
        
       gEventID = Int(currentCell.eventID.text!)
        DispatchQueue.main.async(execute: {

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.show_EVENT)
        })
    }
    
}
