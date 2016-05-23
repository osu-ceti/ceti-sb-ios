//
//  EventDisplay.swift
//  Delphos
//
//  Created by Prabhu on 5/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper


class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate, UISearchBarDelegate, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var btnEvents: SSRadioButton!
    @IBOutlet weak var btnSchools: SSRadioButton!
    @IBOutlet weak var btnUsers: SSRadioButton!
    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var eventBeanSearchArray: [EventBean]! = []
    
    var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
     var backButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
    var listType = EventListingType.ALL
     var menuButton : UIBarButtonItem = UIBarButtonItem()
    @IBOutlet weak var tableView: UITableView!
    var radioButtonController: SSRadioButtonsController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        radioButtonController = SSRadioButtonsController(buttons: btnEvents, btnSchools, btnUsers)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        searchBar.delegate = self
               // Create the navigation bar
        navigationBar = UINavigationBar(frame: CGRectMake(0, 17, self.view.frame.size.width, 44))
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        //self.addRightBarButtonWithImage(UIImage(named: "menu_btn")!)

        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
        // Create left and right button for navigation item

        searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "btnSearchClick:")
        menuButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "menuButtonClick:")

        // Create two buttons for the navigation item
//        let backimage = UIImage(contentsOfFile:"backarrow")
        backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: nil, action: "back:")

        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [searchButton, menuButton]
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
        self.tableView.dataSource = self
        tableView.delegate = self
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
        
        self.tableView.tableFooterView = UIView()
        gBtnRadioValue = "events"
        //self.setNavigationBarItem()
//        if (SchoolBusiness.getRole().equals("Teacher") || SchoolBusiness.getRole().equals("Both")) {
//            ((Button) view.findViewById(R.id.create_event)).setOnClickListener(HomeFragment.this);
//        } else {
//            ((Button) view.findViewById(R.id.create_event)).setVisibility(View.INVISIBLE);
//        }
        
            }
    func back(sender: UIBarButtonItem){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("loginId") as! ViewController
        self.presentViewController(nextViewController,animated:true,completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func menuButtonClick(sender: UIBarButtonItem){
        
    
    }
    
    @IBAction func btnCreateEvent(sender: UIButton) {
    
        let goToCreateEvent = self.storyboard?.instantiateViewControllerWithIdentifier("CreateEventId") as! CreateEventController
        self.presentViewController(goToCreateEvent, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eventsClick(sender: UIButton) {
        gBtnRadioValue = "events"
    }
    @IBAction func btnSchool(sender: UIButton) {
        gBtnRadioValue = "schools"
    }
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }

    func btnAdd(sender:UIButton) {
        print("clicked")
    }
    @IBAction func btnUsers(sender: UIButton) {
        gBtnRadioValue = "users"
    }
    
    func btnSearchClick(sender: UIBarButtonItem) {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = nil
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
        navigationBar.items = [navigationItem]
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("Changed")
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let testfacade = appDelegate.getObjFacade()
//        testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItems = [searchButton, menuButton]
        navigationItem.title = "School-Business"
        searchBar.text = " "
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
        navigationBar.items = [navigationItem]
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("Clicked")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
         testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    func getEventsList(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
    }
    
    @IBAction func eventAll(sender: UIButton) {
       listType = EventListingType.ALL
       getEventsList()
        
    }
    @IBAction func eventApproval(sender: AnyObject) {
        listType = EventListingType.APPROVED
        getEventsList()
    }
    @IBAction func eventClaims(sender: AnyObject) {
        listType = EventListingType.CLAIMS
        getEventsList()
    }
    @IBAction func eventConfirmed(sender: AnyObject) {
        listType = EventListingType.CONFIRMED
        getEventsList()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("eventDisplayId", forIndexPath: indexPath) as? UITableViewCell
        
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