//
//  EventShowController.swift
//  Delphos
//
//  Created by Prabhu on 5/12/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class EventShowController: UIViewController,UINavigationBarDelegate {

    @IBOutlet weak var labeltext1: UILabel!
    @IBOutlet weak var labelText2: UILabel!
    @IBOutlet weak var labelText4: UILabel!
    @IBOutlet weak var labelText5: UILabel!
    @IBOutlet weak var labelText6: UILabel!
    @IBOutlet weak var labelText3: UILabel!

    @IBOutlet weak var txtText1: UILabel!
    @IBOutlet weak var txtText2: UILabel!
    @IBOutlet weak var txtText3: UILabel!
    @IBOutlet weak var txtText4: UILabel!
    @IBOutlet weak var txtText5: UILabel!
    @IBOutlet weak var txtText6: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var claim: UIButton!
    @IBOutlet weak var editEvent: UIButton!
    
    var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Create the navigation bar
        navigationBar = UINavigationBar(frame: CGRectMake(0, 17, self.view.frame.size.width, 44))
        navigationBar.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)
        navigationBar.delegate = self;
        navigationBar.layer.shadowOpacity = 4
        navigationBar.layer.shadowRadius  = 2
        navigationBar.layer.shadowOffset = CGSizeMake(2, 2);
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
        // Create left and right button for navigation item
        
       // searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "btnSearchClick:")
        
        // Create two buttons for the navigation item
        
        let backimage = UIImage(contentsOfFile:"backarrow")
        searchButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: nil, action: "back:")
        navigationItem.leftBarButtonItem = searchButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        

        
        if(gBtnRadioValue == events || gObjShowEventBean != nil) {
            
            self.labeltext1.text = "Speaker:"
            self.labelText2.text = "Event Start:"
            self.labelText3.text = "Event End:"
            self.labelText4.text = "Event Location:"
            self.labelText5.text = "Event Username:"
            self.labelText6.text = "Event content:"
            
            self.txtTitle.text = gObjShowEventBean.title
            self.txtText1.text = gObjShowEventBean.speaker
            self.txtText2.text = gObjShowEventBean.event_start
            self.txtText3.text = gObjShowEventBean.event_end
            self.txtText4.text = gObjShowEventBean.loc_name
            self.txtText5.text = gObjShowEventBean.user_name
            self.txtText6.text = gObjShowEventBean.content
            
           
                self.editEvent.hidden = false
                gClaim = "cancel"
                gEditEvent = "EditEvent"
                editEvent.setTitle( "EditEvent", forState: .Normal)
                claim.setTitle( "Cancel", forState: .Normal)
                
           
                //self.editEvent.hidden = true
                gClaim = "claim"
            
        } else if(gBtnRadioValue == users) {
            
            self.labeltext1.text = "Role:"
            self.labelText2.text = "Biography:"
            self.labelText3.hidden = true
            self.labelText4.hidden = true
            self.labelText5.hidden = true
            self.labelText6.hidden = true
            
            self.txtTitle.text = gObjSearchUserListBean.name
            self.txtText1.text = gObjSearchUserListBean.role
            self.txtText2.text = gObjSearchUserListBean.biography
        }
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

    @IBAction func btnEditEvent(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("CreateEventId") as! CreateEventController
        nextViewController.isEdit = true
        self.presentViewController(nextViewController,animated:true,completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func btnClaim(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        if(gClaim == "claim") {
            testfacade.doTask(self,action: DelphosAction.CLAIM_EVENT)
        } else if(gClaim == "cancel") {
           
            testfacade.doTask(self,action: DelphosAction.CANCEL_CLAIM)
            
        }

    }
}