//
//  NavController.swift
//  Delphos
//
//  Created by Babu on 5/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class NavController: BaseController, UINavigationBarDelegate, UISearchBarDelegate, UITextFieldDelegate {

    
    //var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var backButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
    var menuButton : UIBarButtonItem!
    var searchView: UIView = UIView()
    let zipView:UIView = UIView()

    //var radioButtonController: SSRadioButtonsController?
    var isBackEnabled:Bool = true
    var isSearchEnabled:Bool = true
    var backToController : UIViewController!
    var shouldClose : Bool! = true
    var backButtonNav: String!
    var settingSearch:Bool = false
    let zipText = UITextField(frame: CGRect(x: 110, y: 60, width: 200, height: 20))

    let radiusText = UITextField(frame: CGRect(x: 110, y: 90, width: 200, height: 20))

    
     var notificationCount:String!
    
    var segmentSearchItems = UISegmentedControl(items: ["Events","Schools","Users"])
    
    let zipLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 200, height: 19))

    let zipRadius = UILabel(frame: CGRect(x: 0, y: 90, width: 200, height: 19))
    var nearMeButton: UIButton = UIButton()
    let searchText = UITextField(frame: CGRect(x: 110, y: 30, width: 200, height: 20))
    let searchLabel = UILabel(frame: CGRect(x: 0, y: 30, width: 200, height: 19))
    
    func zipSubViewAdd(){
        searchLabel.textAlignment = NSTextAlignment.left
        searchLabel.text = "Search: "
        searchLabel.textColor = UIColor.black
        zipView.addSubview(searchLabel)
        
        let bottomLineSearch = CALayer()
        bottomLineSearch.frame = CGRect(x: 0.0, y: searchText.frame.height - 1, width: searchText.frame.width, height: 1.0)
        bottomLineSearch.backgroundColor = UIColor.black.cgColor
        searchText.borderStyle = UITextBorderStyle.none
        searchText.layer.addSublayer(bottomLineSearch)
        searchText.delegate = self
        searchText.becomeFirstResponder()
        //zipText.keyboardType = UIKeyboardType.numberPad
        
        searchText.isHidden = false
        searchView.addSubview(searchText)
        
        zipLabel.textAlignment = NSTextAlignment.left
        zipLabel.text = "Zip Code: "
        zipLabel.textColor = UIColor.black
        zipView.addSubview(zipLabel)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: zipText.frame.height - 1, width: zipText.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        zipText.borderStyle = UITextBorderStyle.none
        zipText.layer.addSublayer(bottomLine)
        zipText.delegate = self
        zipText.becomeFirstResponder()
        //zipText.keyboardType = UIKeyboardType.numberPad
        
        zipText.isHidden = false
        searchView.addSubview(zipText)
        
        
        zipRadius.textAlignment = NSTextAlignment.left
        zipRadius.text = "Radius: "
        zipRadius.textColor = UIColor.black
        zipView.addSubview(zipRadius)
        
        let bottomLineRadius = CALayer()
        bottomLineRadius.frame = CGRect(x: 0.0, y: zipText.frame.height - 1, width: zipText.frame.width, height: 1.0)
        bottomLineRadius.backgroundColor = UIColor.black.cgColor
        radiusText.borderStyle = UITextBorderStyle.none
        radiusText.layer.addSublayer(bottomLineRadius)
        radiusText.becomeFirstResponder()
        radiusText.isHidden = false
        searchView.addSubview(radiusText)
        
        
        
        nearMeButton.backgroundColor = UIColor.blue
        nearMeButton.setTitle("Search", for: UIControlState.normal)
        nearMeButton.frame = CGRect(x: 1, y: 120, width: 200, height: 30)
        //        nearMeButton.addTarget(self, action: "nearMeButtonPressed:", for: UIControlEvents.touchUpInside)
        nearMeButton.addTarget(nil, action: #selector(NavController.nearMeButtonPressed(_:)), for:.allEvents)
        nearMeButton.isHidden = false
        searchView.addSubview(nearMeButton)
        
        zipView.isHidden = false
        
        searchView.addSubview(zipView)

    }
    
    func setNavBar(_ width: CGFloat){
        gObjSearchBean.isLocation = false
        searchBar.delegate = self
        searchView.frame = CGRect(x: 0, y: 17+44, width: self.view.frame.size.width, height: 150);
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: 200, height: 19))
        label.textAlignment = NSTextAlignment.left
        label.text = "Search for: "
        label.textColor = UIColor.black
        searchView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
// segmentSearchItems = UISegmentedControl(items: ["Events","Schools","Users"])
        segmentSearchItems.frame  = CGRect(x: 110,y: 5,width: 200,height: 20)
       // segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
        segmentSearchItems.tintColor = UIColor.lightGray
        segmentSearchItems.addTarget(self, action: #selector(NavController.segmentedControllerActivity(_:)), for:.valueChanged)
         

        searchView.addSubview(label)
        
        searchView.addSubview(segmentSearchItems)
        
        zipSubViewAdd()
        
        
        
        self.searchView.isHidden = true
        self.searchBar.isHidden = true
        
        let navigationItem = self.navigationItem
        navigationItem.title = "School-Business"
       
        if(backButtonNav != nil){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.plain, target: self, action: #selector(NavController.backToNavController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
        
        }
        
        
        if(isBackEnabled){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.plain, target: self, action: #selector(NavController.backToSomeController(_:)))
        
            navigationItem.leftBarButtonItem = backButton
        }
        menuButton = self.addRightBarButtonWithImage(UIImage(named: "menu_btn")!)
        
      
       
        
        gBtnNotificationCount = UIBarButtonItem(title : String(gNotificationCount),style: UIBarButtonItemStyle.plain, target: self, action: #selector(NavController.btnNotificationClick(_:)))
        
        
        
        if(isSearchEnabled){
            searchButtonItem = UIBarButtonItem(customView:searchBar)
            searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(NavController.btnSearchClick(_:)))

            navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount, searchButton]
        }
        else{
            navigationItem.rightBarButtonItems = [menuButton]
        }
        
        self.view.addSubview(searchView)
        rightViewController.tableView.reloadData()

    }
    
    func setNavBar1(_ width: CGFloat,height:CGFloat){
        gObjSearchBean.isLocation = false
        searchBar.delegate = self
        searchView.frame = CGRect(x: 0, y: height, width: self.view.frame.size.width, height: 24);
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: 200, height: 19))
        label.textAlignment = NSTextAlignment.left
        label.text = "Search for: "
        label.textColor = UIColor.black
        searchView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.95, alpha: 1.0)

        
       
        
       
        
        segmentSearchItems.frame  = CGRect(x: 110,y: 5,width: 200,height: 20)
        //segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
        segmentSearchItems.tintColor = UIColor.lightGray
        segmentSearchItems.addTarget(self, action: #selector(NavController.segmentedControllerActivity(_:)), for:.valueChanged)
        
        
        zipSubViewAdd()

        searchView.addSubview(label)
        searchView.addSubview(segmentSearchItems)
        
        
        self.searchView.isHidden = true
        self.searchBar.isHidden = true
        let navigationItem = self.navigationItem
        navigationItem.title = "School-Business"
        
        if(backButtonNav != nil){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.plain, target: self, action: #selector(NavController.backToNavController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
            
        }
        
        
        if(isBackEnabled){
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.plain, target: self, action: #selector(NavController.backToSomeController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
        }
        menuButton = self.addRightBarButtonWithImage(UIImage(named: "menu_btn")!)
        
        
        
        
        gBtnNotificationCount = UIBarButtonItem(title : String(gNotificationCount),style: UIBarButtonItemStyle.plain, target: self, action: #selector(NavController.btnNotificationClick(_:)))
        
        
        
        if(isSearchEnabled){
            searchButtonItem = UIBarButtonItem(customView:searchBar)
            searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(NavController.btnSearchClick(_:)))
            
            navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount, searchButton]
        }
        else{
            navigationItem.rightBarButtonItems = [menuButton]
        }
        
        self.view.addSubview(searchView)
        rightViewController.tableView.reloadData()
        
    }

    
    func btnSearchClick(_ sender: UIBarButtonItem) {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
        // It's an iPhone
            if UIDevice.current.orientation.isLandscape {
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
            if(UIDevice.current.orientation.isPortrait) {
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
            break
        case .pad:
        // It's an iPad
            if UIDevice.current.orientation.isLandscape {
                print("landscape")
                if (settingSearch){
                    setNavBar1(self.view.frame.size.width,height:0)
                    searchBar.delegate = self
                }else{
                    print("landscape")
                    setNavBar1(self.view.frame.size.width,height:60)
                    searchBar.delegate = self
                }
                
            }
            if(UIDevice.current.orientation.isPortrait) {
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
            break
        default:
            if UIDevice.current.orientation.isLandscape {
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
            if(UIDevice.current.orientation.isPortrait) {
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
            break
        }
       
        
        

        self.searchBar.isHidden = false
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount,searchButton]
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
        segmentSearchItems.selectedSegmentIndex = 0
        //navigationBar.items = [navigationItem]
        searchView.isHidden = false
        
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
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Changed")
        //        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //        let testfacade = appDelegate.getObjFacade()
        //        testfacade.doTask(self,action: DelphosAction.SEARCH_EVENT)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount,searchButton]
        navigationItem.title = "School-Business"
        searchBar.text = ""
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = false
       
        
        
       // navigationBar.items = [navigationItem]
        searchView.isHidden = true

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Clicked")
        
        var trimmedSearchName = searchBar.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(trimmedSearchName == ""){
            searchBar.text = ""
            searchBar.placeholder = "Please Fill Correct value"
            
            
        
        }else{
            searchBar.text = trimmedSearchName
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.search_EVENT)
            }
    }
    
    
    func backToSomeController(_ sender: UIBarButtonItem){
        //if(backToController == nil){
//            /gObjBackTocontroller = self.fetchNavController(gStrHomeControllerID)
       // }
        
        self.slideMenuController()?.changeMainViewController(gObjBackTocontroller, close: shouldClose)
        
    }
    
    func backToNavController(_ sender: UIBarButtonItem){
        //if(backToController == nil){
        //backToController = self.fetchNavController(backButtonNav)
        // }
        
        self.slideMenuController()?.changeMainViewController(backToController, close: shouldClose)
        
    }
    
    func nearMeButtonPressed(_ sender: UIButton){
        
        print("Near me pressed")
        gObjSearchBean.isLocation = true
        gObjSearchBean.radius = Int(radiusText.text!)
        gObjSearchBean.zip = Int(zipText.text!)
        
//        gObjSearchBean.radius = 53119
//        gObjSearchBean.zip = 100
        gObjSearchBean.searchType = gBtnRadioValue
        


        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.search_ZIPEVENT)

    }
    
    func btnNotificationClick(_ sender: UIBarButtonItem){
        notificationPage = 1
        print(" Notification Click")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.show_NOTIFICATION)
        
    }
    
    func didSelectButton(_ aButton: UIButton?) {
        print(aButton)
    }
    
    func btnAdd(_ sender:UIButton) {
        print("clicked")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func menuButtonClick(_ sender: UIBarButtonItem){
        
        
    }
    func segmentedControllerActivity(_ sender:UISegmentedControl)
    {
        if(sender.selectedSegmentIndex == 0){
            gBtnRadioValue = "events"
            
            zipView.isHidden = false
            zipText.isHidden = false
            radiusText.isHidden = false
            nearMeButton.isHidden = false
        }
        else if(sender.selectedSegmentIndex == 1){
            gBtnRadioValue = "schools"
            zipView.isHidden = false
            zipText.isHidden = false
            radiusText.isHidden = false
            nearMeButton.isHidden = false
        }
        else if(sender.selectedSegmentIndex == 2){
            gBtnRadioValue = "users"
            zipView.isHidden = true
            zipText.isHidden = true
            radiusText.isHidden = true
            nearMeButton.isHidden = true
        }
        
    }
    
   


    
}
