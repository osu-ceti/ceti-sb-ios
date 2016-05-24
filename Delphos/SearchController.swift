//
//  SearchController.swift
//  Delphos
//
//  Created by Prabhu on 5/13/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchController: NavController,UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var usersBeanArray: [userListBean]! = []
   
    
    @IBOutlet weak var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Navbar
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        navigationBar.delegate = self;
        backToView = "HomeID"
       
        
        self.tableVIew.dataSource = self
        tableVIew.delegate = self
        self.tableVIew.tableFooterView = UIView()
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