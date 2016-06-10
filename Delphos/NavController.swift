//
//  NavController.swift
//  Delphos
//
//  Created by Babu on 5/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
class NavController: UIViewController, UINavigationBarDelegate, UISearchBarDelegate, SSRadioButtonControllerDelegate{
    
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
        searchView.frame = CGRectMake(0, 17+44, self.view.frame.size.width, 44);
        let label = UILabel(frame: CGRectMake(0, 0, 110, 21))
        label.textAlignment = NSTextAlignment.Left
        label.text = "Search for:"
        label.textColor = UIColor.blackColor()
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
        
        
        let eventsRadioBtn = buildRadioButton(gSearchEventsRadioTitle,position: CGRectMake(85, 0, 60, 21),actionCallback: #selector(NavController.eventSearch(_:)))
        
        let schoolsRadioBtn = buildRadioButton(gSearchSchoolsRadioTitle,position: CGRectMake(150, 0, 70, 21),actionCallback: #selector(NavController.btnSchool(_:)))
        
        let usersRadioBtn = buildRadioButton(gSearchUsersRadioTitle,position: CGRectMake(230, 0, 60, 21),actionCallback: #selector(NavController.btnUsers(_:)))
        
        radioButtonController = SSRadioButtonsController(buttons: eventsRadioBtn, schoolsRadioBtn, usersRadioBtn)
        
        radioButtonController!.shouldLetDeSelect = true

        
        searchView.addSubview(label)
        searchView.addSubview(eventsRadioBtn)
        searchView.addSubview(schoolsRadioBtn)
        searchView.addSubview(usersRadioBtn)
        
        
        searchView.hidden = true
        
        let navigationItem = self.navigationItem
        navigationItem.title = "School-Business"
       
        if(isBackEnabled){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NavController.backToSomeController(_:)))
        
            navigationItem.leftBarButtonItem = backButton
        }
        menuButton = self.addRightBarButtonWithImage(UIImage(named: "menu_btn")!)
        
        if(isSearchEnabled){
            searchButtonItem = UIBarButtonItem(customView:searchBar)
            searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(NavController.btnSearchClick(_:)))

            navigationItem.rightBarButtonItems = [menuButton, searchButton]
        }
        else{
            navigationItem.rightBarButtonItems = [menuButton]
        }
        
        self.view.addSubview(searchView)
        rightViewController.tableView.reloadData()

    }
    func btnSearchClick(sender: UIBarButtonItem) {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItems = nil
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
        navigationItem.rightBarButtonItems = [menuButton,searchButton]
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
        if(backToController == nil){
            backToController = self.fetchNavController(gStrHomeControllerID)
        }
        
        self.slideMenuController()?.changeMainViewController(backToController, close: shouldClose)     
        
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