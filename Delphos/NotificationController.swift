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
               var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = bgColor
        
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
      
            return notificationArray.count
       
        
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
        
        
         var notificationDisplayBean: NotificationListBean! = notificationArray[indexPath.row]
        
            (cell as! NotificationControllerCell).actUSerName!.text = String(notificationDisplayBean.act_user_name)
        
        (cell as! NotificationControllerCell).eventName!.text = "has claimed your event:" + String(notificationDisplayBean.event_title)
        
         (cell as! NotificationControllerCell).eventId!.text = String(notificationDisplayBean.event_id)
        
        cell.backgroundColor = UIColor(hue: 0.5583, saturation: 0.25, brightness: 0.97, alpha: 1.0)
       
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
        dispatch_async(dispatch_get_main_queue(), {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_EVENT)
        })
    }
    
}
