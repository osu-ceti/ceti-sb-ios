//
//  NavController.swift
//  Delphos
//
//  Created by Babu on 5/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class NavController: BaseController, UINavigationBarDelegate, UISearchBarDelegate {

    
    //var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var backButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
    var menuButton : UIBarButtonItem!
    var searchView: UIView = UIView()
    //var radioButtonController: SSRadioButtonsController?
    var isBackEnabled:Bool = true
    var isSearchEnabled:Bool = true
    var backToController : UIViewController!
    var shouldClose : Bool! = true
    var backButtonNav: String!
    var settingSearch:Bool = false
   // var btnNotification : UIBarButtonItem = UIBarButtonItem()
    
//    var overlayView = UIView()
//    var activityIndicator = UIActivityIndicatorView()
    
     var notificationCount:String!
    
    var segmentSearchItems = UISegmentedControl(items: ["Events","Schools","Users"])
   
    
    func setNavBar(width: CGFloat){
        
        searchBar.delegate = self
        searchView.frame = CGRectMake(0, 17+44, self.view.frame.size.width, 24);
        let label = UILabel(frame: CGRectMake(0, 5, 200, 19))
        label.textAlignment = NSTextAlignment.Left
        label.text = "Search for: "
        label.textColor = UIColor.blackColor()
        searchView.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)
        
        
        
       
        
//        segmentSearchItems = UISegmentedControl(items: ["Events","Schools","Users"])
        segmentSearchItems.frame  = CGRectMake(110,5,200,20)
       // segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
        segmentSearchItems.tintColor = UIColor.lightGrayColor()
        segmentSearchItems.addTarget(self, action: Selector("segmentedControllerActivity:"), forControlEvents:.ValueChanged)
        

        searchView.addSubview(label)
        
        searchView.addSubview(segmentSearchItems)
        
        
        self.searchView.hidden = true
        self.searchBar.hidden = true
        
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
            navigationItem.rightBarButtonItems = [menuButton]
        }
        
        self.view.addSubview(searchView)
        rightViewController.tableView.reloadData()

    }
    
    func setNavBar1(width: CGFloat,height:CGFloat){
        
        searchBar.delegate = self
        searchView.frame = CGRectMake(0, height, self.view.frame.size.width, 24);
        let label = UILabel(frame: CGRectMake(0, 5, 200, 19))
        label.textAlignment = NSTextAlignment.Left
        label.text = "Search for: "
        label.textColor = UIColor.blackColor()
        searchView.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)

        
       
        
       
        
        segmentSearchItems.frame  = CGRectMake(110,5,200,20)
        //segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
        segmentSearchItems.tintColor = UIColor.lightGrayColor()
        segmentSearchItems.addTarget(self, action: Selector("segmentedControllerActivity:"), forControlEvents:.ValueChanged)
        
        
        

        searchView.addSubview(label)
        searchView.addSubview(segmentSearchItems)
        
        
        self.searchView.hidden = true
        self.searchBar.hidden = true
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
            navigationItem.rightBarButtonItems = [menuButton]
        }
        
        self.view.addSubview(searchView)
        rightViewController.tableView.reloadData()
        
    }

    
    func btnSearchClick(sender: UIBarButtonItem) {
        
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            print("landscape")
            if (settingSearch){
                setNavBar1(self.view.frame.size.width,height:0)
                searchBar.delegate = self
            }else{
                print("landscape")
                setNavBar1(self.view.frame.size.width,height:30)
                searchBar.delegate = self
            }
            
        }
        if(UIDevice.currentDevice().orientation.isPortrait.boolValue) {
            print("portrait")

            if (settingSearch){
                setNavBar1(self.view.frame.size.width,height:0)
                searchBar.delegate = self
            }
            else{
                setNavBar(self.view.frame.size.width)
                searchBar.delegate = self
            }
            
        }
        
        

        self.searchBar.hidden = false
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount,searchButton]
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
        segmentSearchItems.selectedSegmentIndex = 0
        //navigationBar.items = [navigationItem]
        searchView.hidden = false
        
        if(segmentSearchItems.selectedSegmentIndex == 0){
            gBtnRadioValue = "events"
            
        }
        else if(segmentSearchItems.selectedSegmentIndex == 1){
            gBtnRadioValue = "schools"
        }
        else if(segmentSearchItems.selectedSegmentIndex == 2){
            gBtnRadioValue = "users"
        }

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
        
        var trimmedSearchName = searchBar.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(trimmedSearchName == ""){
            searchBar.text = ""
            searchBar.placeholder = "Please Fill Correct value"
            
            
        
        }else{
            searchBar.text = trimmedSearchName
        
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
            }
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
    func segmentedControllerActivity(sender:UISegmentedControl)
    {
        if(sender.selectedSegmentIndex == 0){
            gBtnRadioValue = "events"
            
        }
        else if(sender.selectedSegmentIndex == 1){
            gBtnRadioValue = "schools"
        }
        else if(sender.selectedSegmentIndex == 2){
            gBtnRadioValue = "users"
        }
        
    }
    
   


    
}