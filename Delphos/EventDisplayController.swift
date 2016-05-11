//
//  EventDisplay.swift
//  Delphos
//
//  Created by Prabhu on 5/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper


class EventDisplayController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let testfacade = appDelegate.getObjFacade()
//        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
        
         //   eventBeanArray = gObjEventDisplayBean.events
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func eventAll(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EVENT_ALL)
        
       // eventBeanArray = gObjEventDisplayBean.events
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
        var eventDisplayBean: EventBean = eventBeanArray[indexPath.row]
      (cell as! EventDisplayCell).eventName!.text = String(eventDisplayBean.event_title)
     }
    
    //function to return dynamic cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventDisplayID", forIndexPath: indexPath) as? UITableViewCell
        let separatorLineView: UIView = UIView(frame:CGRectMake(0, 0, view.frame.width, 8))
        separatorLineView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        cell!.contentView.addSubview(separatorLineView)
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
}