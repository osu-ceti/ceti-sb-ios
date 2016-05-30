//
//  NavController.swift
//  Delphos
//
//  Created by Babu on 5/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
class NavController: UIViewController, UINavigationBarDelegate, UISearchBarDelegate, SSRadioButtonControllerDelegate{
    
    var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var backButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
    var menuButton : UIBarButtonItem = UIBarButtonItem()
    var backToView: String = "loginId"
    var searchView: UIView = UIView()
    var radioButtonController: SSRadioButtonsController?
    var isBackEnabled:Bool = true
  
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func setNavBar(width: CGFloat){
        searchView.frame = CGRectMake(0, 17+44, self.view.frame.size.width, 44);
        let label = UILabel(frame: CGRectMake(0, 0, 110, 21))
        label.textAlignment = NSTextAlignment.Left
        label.text = "Search for:"
        label.textColor = UIColor.blackColor()
        
        let eventsRadioBtn = SSRadioButton()
        eventsRadioBtn.setTitle("Events", forState: .Normal)
        eventsRadioBtn.circleColor = UIColor.blackColor()
        eventsRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        eventsRadioBtn.frame = CGRectMake(85, 0, 60, 21)
        eventsRadioBtn.titleLabel?.font = UIFont(name: "Times New Roman", size: 15)
        eventsRadioBtn.addTarget(self, action: #selector(NavController.eventSearch(_:)), forControlEvents: UIControlEvents.TouchUpInside)


        let schoolsRadioBtn = SSRadioButton()
        schoolsRadioBtn.setTitle("Schools", forState: .Normal)
        schoolsRadioBtn.circleColor = UIColor.blackColor()
        schoolsRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        schoolsRadioBtn.frame = CGRectMake(150, 0, 70, 21)
        schoolsRadioBtn.titleLabel?.font = UIFont(name: "Times New Roman", size: 15)
        schoolsRadioBtn.addTarget(self, action: #selector(NavController.btnSchool(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let usersRadioBtn = SSRadioButton()
        usersRadioBtn.setTitle("Users", forState: .Normal)
        usersRadioBtn.circleColor = UIColor.blackColor()
        usersRadioBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        usersRadioBtn.frame = CGRectMake(230, 0, 60, 21)
        usersRadioBtn.titleLabel?.font = UIFont(name: "Times New Roman", size: 15)
        usersRadioBtn.addTarget(self, action: #selector(NavController.btnUsers(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        radioButtonController = SSRadioButtonsController(buttons: eventsRadioBtn, schoolsRadioBtn, usersRadioBtn)
        
       // radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true

        
        searchView.addSubview(label)
        searchView.addSubview(eventsRadioBtn)
        searchView.addSubview(schoolsRadioBtn)
        searchView.addSubview(usersRadioBtn)
        
        
        searchView.hidden = true
        
        
        
        navigationBar = UINavigationBar(frame: CGRectMake(0, 17, width , 44))
        navigationBar.backgroundColor = UIColor.clearColor()
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
        // Create left and right button for navigation item
        
        searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(NavController.btnSearchClick(_:)))
        menuButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: #selector(NavController.menuButtonClick(_:)))
        
        // Create two buttons for the navigation item
        //        let backimage = UIImage(contentsOfFile:"backarrow")
        if(isBackEnabled){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: nil, action: #selector(NavController.back(_:)))
        
            navigationItem.leftBarButtonItem = backButton
        }
        navigationItem.rightBarButtonItems = [searchButton, menuButton]
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        self.view.addSubview(searchView)

    }
    func btnSearchClick(sender: UIBarButtonItem) {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = nil
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
        
        navigationBar.items = [navigationItem]
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
        navigationItem.rightBarButtonItems = [searchButton, menuButton]
        navigationItem.title = "School-Business"
        searchBar.text = " "
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
        navigationBar.items = [navigationItem]
        searchView.hidden = true

    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("Clicked")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    
    
    func back(sender: UIBarButtonItem){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier(backToView) as! HomeController
        
        self.presentViewController(nextViewController,animated:true,completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
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