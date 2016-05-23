//
//  SearchController.swift
//  Delphos
//
//  Created by Prabhu on 5/13/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchController: UIViewController,UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate {

    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var usersBeanArray: [userListBean]! = []
    var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
    
    @IBOutlet weak var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create the navigation bar
        navigationBar = UINavigationBar(frame: CGRectMake(0, 17, self.view.frame.size.width, 44))
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
        // Create left and right button for navigation item
        
        //searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "btnSearchClick:")
        
        // Create two buttons for the navigation item
        let backimage = UIImage(contentsOfFile:"backarrow")
        searchButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: nil, action: "back:")
        navigationItem.leftBarButtonItem = searchButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
        self.tableVIew.dataSource = self
        tableVIew.delegate = self
        self.tableVIew.tableFooterView = UIView()
    }
    func back(sender: UIBarButtonItem){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("loginId") as! ViewController
        self.presentViewController(nextViewController,animated:true,completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
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
        if(eventBeanArray.count > 0) {
            return eventBeanArray.count
        } else if(usersBeanArray.count > 0) {
            return usersBeanArray.count
            
        }
        return 0
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
        if(eventBeanArray.count > 0) {
            var eventDisplayBean: EventBean! = eventBeanArray[indexPath.row]
        
            (cell as! SearchControllerCell).txtTitle!.text = String(eventDisplayBean.event_title)
            (cell as! SearchControllerCell).txtIdHidden!.text = String(eventDisplayBean.id)
        } else if(usersBeanArray.count > 0) {
            var usersListBean: userListBean! = usersBeanArray[indexPath.row]
            
            (cell as! SearchControllerCell).txtTitle!.text = String(usersListBean.name)
            (cell as! SearchControllerCell).txtIdHidden!.text = String(usersListBean.id)
        }
        
    }
    
    //function to return dynamic cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchId", forIndexPath: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! SearchControllerCell
        print("currentCell", currentCell.txtIdHidden.text!)
        
        gSearchValue = Int(currentCell.txtIdHidden.text!)
        dispatch_async(dispatch_get_main_queue(), {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_SEARCH)
        })
    }
}