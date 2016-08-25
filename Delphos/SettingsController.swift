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
    
    override func viewWillAppear(animated: Bool) {
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
    @IBOutlet var viewSetting: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        rootViewController = self
        settingSearch = true
        
        view.backgroundColor = bgColor
        viewSetting.backgroundColor = bgColor
        if(settingsBean.set_updates == 1){
            switchEventUpdate.on = true
            
        }
        else{
            switchEventUpdate.on = false
        }
        
        if(settingsBean.set_confirm == 1){
            switchConfirmation.on = true
         }
         else{
            switchConfirmation.on = false
        
        }
       
        if(settingsBean.set_claims == 1){
            switchEventClaim.on = true
        }
        else{
            switchEventClaim.on = false
        
        }
        
        
        
        
    }
    @IBAction func btnSaveSettingsClick(sender: AnyObject) {
        
        
        
        
        
        if(switchEventUpdate.on == true){
           radioEventUpdateBean = true
            print("true")
        }
        else{
            radioEventUpdateBean = false
        
        }
        if(switchConfirmation.on == true){
            radioComfirmationsBean = true
             print("true")
        }
        else{
            radioComfirmationsBean = false
             print("false")
        }
        if(switchEventClaim.on == true){
            radioEventClaimBean = true
             print("true")
        }else{
            radioEventClaimBean = false
             print("false")
        
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SAVE_SETTINGS)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnSaveSettings.frame.origin.y + 150)
        //scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.x + 700)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
    }
}
