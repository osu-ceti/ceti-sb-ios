//
//  NavController.swift
//  Delphos
//
//  Created by Babu on 5/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NavController: BaseController, UINavigationBarDelegate, UISearchBarDelegate, UITextFieldDelegate,CLLocationManagerDelegate {

    
    var locationManager : CLLocationManager!
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
    
    let locationSwitch = UISwitch()
    let locationSwitchLabel = UILabel(frame: CGRect(x: 185, y: 60, width: 200, height: 19))
   
    
    var zipText = UITextField(frame: CGRect(x: 90, y: 60, width: 60, height: 20))
    var radiusText = UITextField(frame: CGRect(x: 90, y: 90, width: 200, height: 20))
    
     var notificationCount:String!
    
    var segmentSearchItems = UISegmentedControl(items: ["Events","Schools","Users"])
    
    let zipLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 200, height: 19))

    let zipRadius = UILabel(frame: CGRect(x: 0, y: 90, width: 200, height: 19))
    var nearMeButton: UIButton = UIButton()
    let searchText = UITextField(frame: CGRect(x: 90, y: 30, width: 200, height: 20))
    let searchLabel = UILabel(frame: CGRect(x: 0, y: 30, width: 200, height: 19))
    var searchCancelBtn: UIButton = UIButton()
    func zipSubViewAdd(){
        searchText.placeholder = "Search"
        zipText.placeholder = "Zipcode"
        radiusText.placeholder = "Radius"
        
        searchText.font =  searchText.font?.withSize(12)
        zipText.font =  zipText.font?.withSize(12)
        radiusText.font =  radiusText.font?.withSize(12)
        
        searchLabel.textAlignment = NSTextAlignment.left
        searchLabel.text = "With: "
        searchLabel.textColor = UIColor.black
        
        zipText.keyboardType = UIKeyboardType.numberPad
        radiusText.keyboardType = UIKeyboardType.numberPad
        
        searchView.addSubview(searchLabel)
        
        let bottomLineSearch = CALayer()
        bottomLineSearch.frame = CGRect(x: 0.0, y: searchText.frame.height - 1, width: searchText.frame.width, height: 1.0)
        bottomLineSearch.backgroundColor = UIColor.black.cgColor
        searchText.borderStyle = UITextBorderStyle.none
        searchText.layer.addSublayer(bottomLineSearch)
        searchText.delegate = self
        //searchText.becomeFirstResponder()
        
        searchText.resignFirstResponder()
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
        //zipText.becomeFirstResponder()
        //zipText.keyboardType = UIKeyboardType.numberPad
        
        zipText.isHidden = false
        searchView.addSubview(zipText)
        
        
        zipRadius.textAlignment = NSTextAlignment.left
        zipRadius.text = "Radius: "
        zipRadius.textColor = UIColor.black
        zipView.addSubview(zipRadius)
        
        zipView.isHidden = false
        
        searchView.addSubview(zipView)

        
        let bottomLineRadius = CALayer()
        bottomLineRadius.frame = CGRect(x: 0.0, y: zipText.frame.height - 1, width: zipText.frame.width, height: 1.0)
        bottomLineRadius.backgroundColor = UIColor.black.cgColor
        radiusText.borderStyle = UITextBorderStyle.none
        radiusText.layer.addSublayer(bottomLineRadius)
        radiusText.delegate = self

        //radiusText.becomeFirstResponder()
        radiusText.isHidden = false
        searchView.addSubview(radiusText)
        
        
        locationSwitchLabel.textAlignment = NSTextAlignment.left
        locationSwitchLabel.text = "Use my location's zipcode"
        locationSwitchLabel.font = UIFont.systemFont(ofSize: 10)
        locationSwitchLabel.textColor = UIColor.black
        searchView.addSubview(locationSwitchLabel)
        
        locationSwitch.transform = CGAffineTransform(scaleX: 0.50, y: 0.50);
        locationSwitch.frame = CGRect(x: 155, y: 60, width: 200, height: 19)
        //locationSwitch.becomeFirstResponder()
        locationSwitch.accessibilityValue = "Use my zipcode"
        locationSwitch.isHidden = false
        locationSwitchLabel.isHidden = false

        locationSwitch.addTarget(self, action: Selector("getLocationFromGPS:"), for: UIControlEvents.valueChanged)
        searchView.addSubview(locationSwitch)
        
        
        nearMeButton.backgroundColor = UIColor.blue
        nearMeButton.setTitle("Search", for: UIControlState.normal)
        nearMeButton.frame = CGRect(x: 60, y: 115, width: 100, height: 30)
        //        nearMeButton.addTarget(self, action: "nearMeButtonPressed:", for: UIControlEvents.touchUpInside)
        nearMeButton.addTarget(nil, action: #selector(NavController.nearMeButtonPressed(_:)), for:.allEvents)
        nearMeButton.isHidden = false
        searchView.addSubview(nearMeButton)
        
        searchCancelBtn.backgroundColor = UIColor.blue
        searchCancelBtn.setTitle("Cancel", for: UIControlState.normal)
        searchCancelBtn.frame = CGRect(x: 170, y: 115, width: 100, height: 30)
        searchCancelBtn.addTarget(self, action: #selector(NavController.cancelBtnClick(_:)), for:.allEvents)
        searchCancelBtn.isHidden = false
        searchView.addSubview(searchCancelBtn)
        
        
        
        locationManager = CLLocationManager()

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
        searchView.frame = CGRect(x: 0, y: height, width: self.view.frame.size.width, height: 150);
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
       
        
        

        self.searchBar.isHidden = true
        
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
        searchBar.text = DelphosStrings.EMPTY_STRING
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = false
       
        
        
       // navigationBar.items = [navigationItem]
        searchView.isHidden = true

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Clicked")
        
        var trimmedSearchName = searchBar.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(trimmedSearchName == DelphosStrings.EMPTY_STRING){
            searchBar.text = DelphosStrings.EMPTY_STRING
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
    func cancelBtnClick(_ sender: UIButton){
        print("cancel btn")
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItems = [menuButton,gBtnNotificationCount,searchButton]
        navigationItem.title = "School-Business"
        searchBar.text = DelphosStrings.EMPTY_STRING
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = false
        searchView.isHidden = true
        
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
        gObjSearchBean.searchText = searchText.text!
        var searchFunction = false

        gObjSearchBean.searchType = gBtnRadioValue
       
        var trimmedSearchText = gObjSearchBean.searchText!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(gObjSearchBean.searchType != gUsers){
            if(trimmedSearchText == gEmptyString){
                
                if(zipText.text! == gEmptyString && radiusText.text! == gEmptyString){
                    
                    self.showAlert(self, strMessage: gSearchTextErrorMsg)
                    
                }else if((zipText.text! != gEmptyString && radiusText.text! == gEmptyString) || (zipText.text! == gEmptyString && radiusText.text! != gEmptyString) ){
                    
                    self.showAlert(self, strMessage: gZipcodeTextErrorMsg)
                }
                else{
                    searchFunction = true
                }
                
            }
            else{
                gObjSearchBean.searchText = trimmedSearchText
                searchFunction = true
            }
        }
        else {
            if(trimmedSearchText == gEmptyString){
                self.showAlert(self, strMessage: gSearchTextErrorMsg)
            }
            else{
                gObjSearchBean.searchText = trimmedSearchText
                searchFunction = true
                
                
            }
            
        }
        if(searchFunction == true){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.search_ZIPEVENT)
        }
        

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
            locationSwitch.isHidden = false
            locationSwitchLabel.isHidden = false
        }
        else if(sender.selectedSegmentIndex == 1){
            gBtnRadioValue = "schools"
            zipView.isHidden = false
            zipText.isHidden = false
            radiusText.isHidden = false
            nearMeButton.isHidden = false
            locationSwitch.isHidden = false
            locationSwitchLabel.isHidden = false

        }
        else if(sender.selectedSegmentIndex == 2){
            gBtnRadioValue = "users"
            zipView.isHidden = true
            zipText.isHidden = true
            radiusText.isHidden = true
            nearMeButton.isHidden = false
            locationSwitch.isHidden = true
            locationSwitchLabel.isHidden = true
        }
        
    }
    func getLocationFromGPS(_ sender: UISwitch){
        
        if(self.locationSwitch.isOn){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        else{
            print("locationSwitch is off")
        }
        
        
    }
   
    
    
    /**
     * Method to get acccurate location using geocoder
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if error != nil {
                print("reverse geocoder failed with error \(error?.localizedDescription)")
                return
            }
            if (placemarks?.count)! > 0 {
                let pm = placemarks![0] 
                self.displayLocationInfo(placemark: pm)
            } else {
                print("problem with the data received from geocoder")
            }
        })
    }
    
    /**
     * Method to display location after location manager gets location
     */
    func displayLocationInfo(placemark: CLPlacemark) {
        //stop updating location to save battery life
        self.locationManager.stopUpdatingLocation()
        print("Placement = ",placemark.postalCode!)
        zipText.text = placemark.postalCode!
        
    }
    
    
    /**
     * Method to show error if location doesn't locate
     */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error getting location \(error.localizedDescription)")
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
        -> Bool
    {
        // We ignore any change that doesn't add characters to the text field.
        // These changes are things like character deletions and cuts, as well
        // as moving the insertion point.
        //
        // We still return true to allow the change to take place.
        if string.characters.count == 0 {
            return true
        }
        
        // Check to see if the text field's contents still fit the constraints
        // with the new content added to it.
        // If the contents still fit the constraints, allow the change
        // by returning true; otherwise disallow the change by returning false.
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
            
            // Allow only upper- and lower-case vowels in this field,
        // and limit its contents to a maximum of 6 characters.
                    // Allow any characters EXCEPT upper- and lower-case vowels in this field,
        // and limit its contents to a maximum of 8 characters.
               case zipText:
                if(Int(prospectiveText) == nil){
                    return false
                }
                break
            
              case radiusText:
                if(Int(prospectiveText) == nil){
                    return false
                }
                break
            
  
        default:
            return true
        }
        return true
    }
    
    func checkForNull(txtField: String)->String{
        if(txtField == nil || (txtField != nil &&
            (txtField == "Null"
                || txtField == "null"
                || txtField == "NULL"))){
            return gEmptyString
        }
        return txtField
    }
    
}
