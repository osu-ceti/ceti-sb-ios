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
    
    @IBOutlet var radioEventUpdate: SSRadioButton!
    @IBOutlet var radioComfirmations: SSRadioButton!    
    @IBOutlet var radioEventClaim: SSRadioButton!
    
   
    @IBOutlet var btnSaveSettings: UIButton!
    
   
   
    var radioButtonControllerEventUpdate: SSRadioButtonsController?
    var radioButtonControllerComfirmations: SSRadioButtonsController?
    var radioButtonControllerEventClaim: SSRadioButtonsController?
    
    @IBOutlet var scrollView: UIScrollView!
   
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
               radioButtonControllerEventUpdate = SSRadioButtonsController(buttons: radioEventUpdate)
        radioButtonControllerEventUpdate!.delegate = self
        radioButtonControllerEventUpdate!.shouldLetDeSelect = true
        
        radioButtonControllerComfirmations = SSRadioButtonsController(buttons: radioComfirmations)
        radioButtonControllerComfirmations!.delegate = self
        radioButtonControllerComfirmations!.shouldLetDeSelect = true
        
        radioButtonControllerEventClaim = SSRadioButtonsController(buttons: radioEventClaim)
        radioButtonControllerEventClaim!.delegate = self
        radioButtonControllerEventClaim!.shouldLetDeSelect = true
        
        
        
        rootViewController = self
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        if(settingsBean.set_updates == 1){
            radioEventUpdate.selected = true
        }
        else{
            radioEventUpdate.selected = false
        }
        
        if(settingsBean.set_confirm == 1){
            radioComfirmations.selected = true
         }
         else{
            radioComfirmations.selected = false
        
        }
       
        if(settingsBean.set_claims == 1){
            radioEventClaim.selected = true
        }
        else{
            radioEventClaim.selected = false
        
        }
        
        
        
        
    }
    @IBAction func btnSaveSettingsClick(sender: AnyObject) {
        
        
        
        
        
        if(radioEventUpdate.selected == true){
           radioEventUpdateBean = true
            print("true")
        }
        else{
            radioEventUpdateBean = false
        
        }
        if(radioComfirmations.selected == true){
            radioComfirmationsBean = true
             print("true")
        }
        else{
            radioComfirmationsBean = false
             print("false")
        }
        if(radioEventClaim.selected == true){
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
