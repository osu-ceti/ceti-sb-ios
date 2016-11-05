//
//  SettingsController.swift
//  Delphos
//
//  Created by Babu on 7/20/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class SettingsController: NavController {
    
   
    
   
    @IBOutlet var btnSaveSettings: UIButton!
    
   
   
   
    
    @IBOutlet var scrollView: UIScrollView!
    
   
    @IBOutlet var switchEventUpdate: UISwitch!
    
    @IBOutlet var switchEventClaim: UISwitch!
    
    @IBOutlet var switchConfirmation: UISwitch!
    
    
    var radioEventUpdateBean: Bool!
    var radioComfirmationsBean: Bool!
    var radioEventClaimBean: Bool!
    
    var settingsBean :ViewSettingsResponse!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = false
        
        var view1 = UIViewController()
        setNavBar1(self.view.frame.size.width,height: 0)
        
        //setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    @IBOutlet var endLineView: UIView!
    @IBOutlet var viewSetting: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        rootViewController = self
        settingSearch = true
        
        self.view.backgroundColor = bgColor
        viewSetting.backgroundColor = bgColor
        if(settingsBean.set_updates != nil){
            if(settingsBean.set_updates == 1){
                switchEventUpdate.isOn = true
            
            }
            else{
                switchEventUpdate.isOn = false
            }
        }
        if(settingsBean.set_confirm != nil){
            if(settingsBean.set_confirm == 1){
                switchConfirmation.isOn = true
            }
            else{
                switchConfirmation.isOn = false
        
            }
        }
        if(settingsBean.set_claims != nil){
            if(settingsBean.set_claims == 1){
                switchEventClaim.isOn = true
            }
            else{
                switchEventClaim.isOn = false
        
            }
        }
        if(UIDevice.current.orientation.isLandscape) {
            print("landscape")
            endLineView.frame = CGRect(x: 0,y: 200,width: 700,height: 1)
        }
        
        
        
    }
    @IBAction func btnSaveSettingsClick(_ sender: AnyObject) {
        
        
        
        
        
        if(switchEventUpdate.isOn == true){
           radioEventUpdateBean = true
            print("true")
        }
        else{
            radioEventUpdateBean = false
        
        }
        if(switchConfirmation.isOn == true){
            radioComfirmationsBean = true
             print("true")
        }
        else{
            radioComfirmationsBean = false
             print("false")
        }
        if(switchEventClaim.isOn == true){
            radioEventClaimBean = true
             print("true")
        }else{
            radioEventClaimBean = false
             print("false")
        
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.save_SETTINGS)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.btnSaveSettings.frame.origin.y + 150)
        //scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.x + 700)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
}
