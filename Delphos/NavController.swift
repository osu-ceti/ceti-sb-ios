//
//  NavController.swift
//  Delphos
//
//  Created by Babu on 5/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
class NavController: BaseController, UINavigationBarDelegate, UISearchBarDelegate, SSRadioButtonControllerDelegate{
    
    //var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var backButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
    var menuButton : UIBarButtonItem!
    var searchView: UIView = UIView()
    var radioButtonController: SSRadioButtonsController?
    var isBackEnabled:Bool = true
    var isSearchEnabled:Bool = true
    var backToController : UIViewController!
    var shouldClose : Bool! = true
    var backButtonNav: String!
   // var btnNotification : UIBarButtonItem = UIBarButtonItem()
    
//    var overlayView = UIView()
//    var activityIndicator = UIActivityIndicatorView()
    
     var notificationCount:String!
     var eventsRadioBtn = SSRadioButton()
    var schoolsRadioBtn = SSRadioButton()
    var usersRadioBtn = SSRadioButton()
   
    
    func buildRadioButton(title: String, position:CGRect, actionCallback:Selector) ->SSRadioButton{
        
        let eventsRadioBtn = SSRadioButton()
        eventsRadioBtn.setTitle(title, forState: .Normal)
        eventsRadioBtn.circleColor = UIColor.blackColor()
        eventsRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        eventsRadioBtn.frame = position
        eventsRadioBtn.titleLabel?.font = UIFont(name: gFontName, size: 15)
        eventsRadioBtn.addTarget(self, action: actionCallback, forControlEvents: UIControlEvents.TouchUpInside)
        return eventsRadioBtn
    }
    
    func setNavBar(width: CGFloat){
        
        searchBar.delegate = self
        searchView.frame = CGRectMake(0, 17+44, self.view.frame.size.width, 24);
        let label = UILabel(frame: CGRectMake(0, 0, 200, 19))
        label.textAlignment = NSTextAlignment.Left
        label.text = "Search for: "
        label.textColor = UIColor.blackColor()
        searchView.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)
//        
//        let eventsRadioBtn = SSRadioButton()
//        eventsRadioBtn.setTitle("Events", forState: .Normal)
//        eventsRadioBtn.circleColor = UIColor.blackColor()
//        eventsRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        eventsRadioBtn.frame = CGRectMake(85, 0, 60, 21)
//        eventsRadioBtn.titleLabel?.font = UIFont(name: gFontName, size: 15)
//        eventsRadioBtn.addTarget(self, action: #selector(NavController.eventSearch(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        

//        let schoolsRadioBtn = SSRadioButton()
//        schoolsRadioBtn.setTitle("Schools", forState: .Normal)
//        schoolsRadioBtn.circleColor = UIColor.blackColor()
//        schoolsRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        schoolsRadioBtn.frame = CGRectMake(150, 0, 70, 21)
//        schoolsRadioBtn.titleLabel?.font = UIFont(name: gFontName, size: 15)
//        schoolsRadioBtn.addTarget(self, action: #selector(NavController.btnSchool(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
//        let usersRadioBtn = SSRadioButton()
//        usersRadioBtn.setTitle("Users", forState: .Normal)
//        usersRadioBtn.circleColor = UIColor.blackColor()
//        usersRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        usersRadioBtn.frame = CGRectMake(230, 0, 60, 21)
//        usersRadioBtn.titleLabel?.font = UIFont(name: gFontName, size: 15)
//        usersRadioBtn.addTarget(self, action: #selector(NavController.btnUsers(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
          eventsRadioBtn = buildRadioButton(gSearchEventsRadioTitle,position: CGRectMake(85, 0, 60, 21),actionCallback: #selector(NavController.eventSearch(_:)))
        
         schoolsRadioBtn = buildRadioButton(gSearchSchoolsRadioTitle,position: CGRectMake(150, 0, 70, 21),actionCallback: #selector(NavController.btnSchool(_:)))
        
         usersRadioBtn = buildRadioButton(gSearchUsersRadioTitle,position: CGRectMake(230, 0, 60, 21),actionCallback: #selector(NavController.btnUsers(_:)))
        
        radioButtonController = SSRadioButtonsController(buttons: eventsRadioBtn, schoolsRadioBtn, usersRadioBtn)
        //radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true

        eventsRadioBtn.selected = true
        searchView.addSubview(label)
        searchView.addSubview(eventsRadioBtn)
        searchView.addSubview(schoolsRadioBtn)
        searchView.addSubview(usersRadioBtn)
        
        
        searchView.hidden = true
        
        let navigationItem = self.navigationItem
        navigationItem.title = "School-Business"
       
        if(backButtonNav != nil){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NavController.backToNavController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
        
        }
        
        
        if(isBackEnabled){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NavController.backToSomeController(_:)))
        
            navigationItem.leftBarButtonItem = backButton
        }
        menuButton = self.addRightBarButtonWithImage(UIImage(named: "menu_btn")!)
        
      
       
        
        gBtnNotificationCount = UIBarButtonItem(title : String(gNotificationCount),style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NavController.btnNotificationClick(_:)))
        
        
        
        if(isSearchEnabled){
            searchButtonItem = UIBarButtonItem(customView:searchBar)
            searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(NavController.btnSearchClick(_:)))

            navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount, searchButton]
        }
        else{
            navigationItem.rightBarButtonItems = [gBtnNotificationCount,menuButton]
        }
        
        self.view.addSubview(searchView)
        rightViewController.tableView.reloadData()

    }
    func setNavBar1(width: CGFloat,height:CGFloat){
        
        searchBar.delegate = self
        searchView.frame = CGRectMake(0, height, self.view.frame.size.width, 24);
        let label = UILabel(frame: CGRectMake(0, 0, 200, 19))
        label.textAlignment = NSTextAlignment.Left
        label.text = "Search for: "
        label.textColor = UIColor.blackColor()
        searchView.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)
        //
        //        let eventsRadioBtn = SSRadioButton()
        //        eventsRadioBtn.setTitle("Events", forState: .Normal)
        //        eventsRadioBtn.circleColor = UIColor.blackColor()
        //        eventsRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //        eventsRadioBtn.frame = CGRectMake(85, 0, 60, 21)
        //        eventsRadioBtn.titleLabel?.font = UIFont(name: gFontName, size: 15)
        //        eventsRadioBtn.addTarget(self, action: #selector(NavController.eventSearch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        //        let schoolsRadioBtn = SSRadioButton()
        //        schoolsRadioBtn.setTitle("Schools", forState: .Normal)
        //        schoolsRadioBtn.circleColor = UIColor.blackColor()
        //        schoolsRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //        schoolsRadioBtn.frame = CGRectMake(150, 0, 70, 21)
        //        schoolsRadioBtn.titleLabel?.font = UIFont(name: gFontName, size: 15)
        //        schoolsRadioBtn.addTarget(self, action: #selector(NavController.btnSchool(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //        let usersRadioBtn = SSRadioButton()
        //        usersRadioBtn.setTitle("Users", forState: .Normal)
        //        usersRadioBtn.circleColor = UIColor.blackColor()
        //        usersRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //        usersRadioBtn.frame = CGRectMake(230, 0, 60, 21)
        //        usersRadioBtn.titleLabel?.font = UIFont(name: gFontName, size: 15)
        //        usersRadioBtn.addTarget(self, action: #selector(NavController.btnUsers(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        eventsRadioBtn = buildRadioButton(gSearchEventsRadioTitle,position: CGRectMake(85, 0, 60, 21),actionCallback: #selector(NavController.eventSearch(_:)))
        
        schoolsRadioBtn = buildRadioButton(gSearchSchoolsRadioTitle,position: CGRectMake(150, 0, 70, 21),actionCallback: #selector(NavController.btnSchool(_:)))
        
        usersRadioBtn = buildRadioButton(gSearchUsersRadioTitle,position: CGRectMake(230, 0, 60, 21),actionCallback: #selector(NavController.btnUsers(_:)))
        
        radioButtonController = SSRadioButtonsController(buttons: eventsRadioBtn, schoolsRadioBtn, usersRadioBtn)
        //radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        eventsRadioBtn.selected = true
        searchView.addSubview(label)
        searchView.addSubview(eventsRadioBtn)
        searchView.addSubview(schoolsRadioBtn)
        searchView.addSubview(usersRadioBtn)
        
        
        searchView.hidden = true
        
        let navigationItem = self.navigationItem
        navigationItem.title = "School-Business"
        
        if(backButtonNav != nil){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NavController.backToNavController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
            
        }
        
        
        if(isBackEnabled){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NavController.backToSomeController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
        }
        menuButton = self.addRightBarButtonWithImage(UIImage(named: "menu_btn")!)
        
        
        
        
        gBtnNotificationCount = UIBarButtonItem(title : String(gNotificationCount),style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NavController.btnNotificationClick(_:)))
        
        
        
        if(isSearchEnabled){
            searchButtonItem = UIBarButtonItem(customView:searchBar)
            searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(NavController.btnSearchClick(_:)))
            
            navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount, searchButton]
        }
        else{
            navigationItem.rightBarButtonItems = [gBtnNotificationCount,menuButton]
        }
        
        self.view.addSubview(searchView)
        rightViewController.tableView.reloadData()
        
    }

    
    func btnSearchClick(sender: UIBarButtonItem) {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount,searchButton]
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
        
        //navigationBar.items = [navigationItem]
        searchView.hidden = false

    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("Changed")
        //        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //        let testfacade = appDelegate.getObjFacade()
        //        testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount,searchButton]
        navigationItem.title = "School-Business"
        searchBar.text = ""
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = false
       
        
        
       // navigationBar.items = [navigationItem]
        searchView.hidden = true

    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("Clicked")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    
    
    func backToSomeController(sender: UIBarButtonItem){
        //if(backToController == nil){
//            /gObjBackTocontroller = self.fetchNavController(gStrHomeControllerID)
       // }
        
        self.slideMenuController()?.changeMainViewController(gObjBackTocontroller, close: shouldClose)
        
    }
    
    func backToNavController(sender: UIBarButtonItem){
        //if(backToController == nil){
        //backToController = self.fetchNavController(backButtonNav)
        // }
        
        self.slideMenuController()?.changeMainViewController(backToController, close: shouldClose)
        
    }
    func btnNotificationClick(sender: UIBarButtonItem){
       
        print(" Notification Click")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SHOW_NOTIFICATION)
        
    }
    
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }
    
    func btnAdd(sender:UIButton) {
        print("clicked")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func menuButtonClick(sender: UIBarButtonItem){
        
        
    }
    
    func eventSearch(sender:UIButton){
        gBtnRadioValue = "events"
         
    }
    
    func btnSchool(sender: UIButton) {
        gBtnRadioValue = "schools"
            }
    
    func btnUsers(sender: UIButton) {
        gBtnRadioValue = "users"
        
    }


    
}