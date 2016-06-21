//
//  SearchController.swift
//  Delphos
//
//  Created by Prabhu on 5/13/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchController: NavController, UITableViewDataSource, UITableViewDelegate {

    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var usersBeanArray: [userListBean]! = []
    var schoolBeanArray: [userListBean]! = []
    
    @IBOutlet weak var eventFound: UILabel!
    
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = true
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Navbar
//        setNavBar(self.view.frame.size.width)
//        searchBar.delegate = self
//        navigationBar.delegate = self;
//        backToView = "HomeID"
//       
        self.eventFound.hidden = true
        self.tableVIew.dataSource = self
        tableVIew.delegate = self
        self.tableVIew.tableFooterView = UIView()
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        self.tableVIew.backgroundColor = bgColor
       
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
        return 1
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
       
        if(eventBeanArray.count > 0) {
            var eventDisplayBean: EventBean! = eventBeanArray[indexPath.row]
            //(cell as! SearchControllerCell).startdate.hidden = false
            (cell as! SearchControllerCell).txtTitle!.text = String(eventDisplayBean.event_title)
            (cell as! SearchControllerCell).txtIdHidden!.text = String(eventDisplayBean.id)
            (cell as! SearchControllerCell).startdate!.text = String(eventDisplayBean.event_start)
                  } else if(usersBeanArray.count > 0) {
            var usersListBean: userListBean! = usersBeanArray[indexPath.row]
            
            (cell as! SearchControllerCell).txtTitle!.text = String(usersListBean.name)
            (cell as! SearchControllerCell).txtIdHidden!.text = String(usersListBean.id)
            (cell as! SearchControllerCell).startdate!.text = usersListBean.association
                    }
        else{
             cell.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
           if(gBtnRadioValue == "events") {
             self.eventFound.hidden = false
            self.tableVIew.hidden = true
            self.eventFound.text = "No Events Found"
            }
           else if(gBtnRadioValue == "users") {
             self.eventFound.hidden = false
             self.tableVIew.hidden = true
             self.eventFound.text = "No Users Found"
            }
           else{
            self.eventFound.hidden = false
             self.tableVIew.hidden = true
            self.eventFound.text = "No Schools Found"
            }
            //(cell as! SearchControllerCell).txtTitle.hidden = true
            //(cell as! SearchControllerCell).startdate.hidden = true
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