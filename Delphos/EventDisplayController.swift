//
//  EventDisplay.swift
//  Delphos
//
//  Created by Prabhu on 5/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper


class EventDisplayController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate, UISearchBarDelegate {
    
    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var eventBeanSearchArray: [EventBean]! = []
    
    @IBOutlet weak var txtSearchEvent: UITextField!
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 130, 15))
    var searchBarItem = UIBarButtonItem()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
               // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Events"
       // var searchBar = UISearchBar(frame: CGRectMake(0, 0, 130, 15))
        var searchButtonItem = UIBarButtonItem(customView:searchBar)
        
        // Create left and right button for navigation item
        let leftButton: UIBarButtonItem =  UIBarButtonItem(title: "Save", style:   UIBarButtonItemStyle.Plain, target: self, action: "btn_clicked:")
        var searchButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "btnSearchClick:")
        
//        searchBar.delegate = self
//        
//        searchBar.searchBarStyle = UISearchBarStyle.Minimal
//        navigationItem.rightBarButtonItem = searchBarItem
//
        // Create two buttons for the navigation item
       navigationItem.rightBarButtonItem = searchButtonItem
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
      //  searchBar.showsCancelButton = true
        
       self.tableView.dataSource = self
        tableView.delegate = self
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
        
        self.tableView.tableFooterView = UIView()
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func btnAdd(sender:UIButton) {
        print("clicked")
    }
    
    func btnSearchClick(sender: UIBarButtonItem) {
        // Do something
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButtonItem(nil, animated: true)
        UIView.animateWithDuration(0.5, animations: {
            self.searchBar.alpha = 1
            }, completion: { finished in
                self.searchBar.becomeFirstResponder()
        })
    }
    
    @IBAction func btnSearch(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("Changed")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    
    @IBAction func eventAll(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
        
    }
    @IBAction func eventApproval(sender: AnyObject) {
        
    }
    @IBAction func eventClaims(sender: AnyObject) {
    }
    @IBAction func eventConfirmed(sender: AnyObject) {
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