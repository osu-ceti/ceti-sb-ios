//
//  RightViewController.swift
//  Delphos
//
//  Created by Babu on 5/23/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

//
//  RightViewController.swift
//  Outlook
//
//  Created by arun on 5/22/15.
//  Copyright (c) 2015 OntoBorn. All rights reserved.
//

import UIKit


class RightViewController: BaseController, UIWebViewDelegate {
    
    enum Menu: Int {
        case home = 0
        case settings
        case profile
        case viewMyBadges
        case about
        case logout
       
        
    }
    @IBOutlet var tableView: UITableView!
    var isRegister: Bool = false
    
    var homeController: UIViewController!
    
    
    convenience init() {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideOverlayView()
        rootViewController = self
        gObjHomeController = fetchNavController(gStrHomeControllerID)
        
        gObjLoginController = fetchNavController(gStrLoginControllerID) 
        
        // self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        
        
//        
//        gObjHomeController = storyboard.instantiateViewControllerWithIdentifier("HomeID") as! HomeController
//        self.homeController = UINavigationController(rootViewController: homeController)
        //var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */

        //self.tableView.backgroundColor = bgColor
       
        
        self.tableView.tableFooterView = UIView()
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func hidingOverlay(){
        self.hideOverlayView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = UIColor.white
        cell.textLabel!.font = UIFont.italicSystemFont(ofSize: 16)
        cell.textLabel!.textColor = UIColor.black
        cell.textLabel!.text = menus[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.showOverlay(self.view)
        if let menu = Menu(rawValue: (indexPath as NSIndexPath).item) {
            
            switch menu {
            case .home:
                if(isRegister){
                    rootViewController = gObjLoginController
                    self.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                }
                else{
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    
                    self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true )
                    rootViewController = gObjHomeController
                    //self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                    
                    
                
                   
                }
                break
                
            case .settings:
                //self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let testfacade = appDelegate.getObjFacade()
                testfacade.doTask(self,action: DelphosAction.view_SETTINGS)
                break
            case .profile:
               // self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let testfacade = appDelegate.getObjFacade()
                testfacade.doTask(self,action: DelphosAction.user_PROFILE)
                
                
                break
            case .viewMyBadges:
                
                // self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                
                gUserVIewBadgeId = gObjUserBean.id
                //showOverlay(self.view)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let testfacade = appDelegate.getObjFacade()
                testfacade.doTask(self,action: DelphosAction.show_USER_PROFILE)
                
                break
            case .about:
                gObjAboutControllerNav = self.fetchNavController(gStrAboutControllerID)
                
                self.slideMenuController()?.changeMainViewController(gObjAboutControllerNav, close: true)
                
                    
                
                break
            case .logout:
                //self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let testfacade = appDelegate.getObjFacade()
                testfacade.doTask(self,action: DelphosAction.sign_OUT)

                break
            

            }
        }
        gObjRightViewController = self
        
    }
    
   
   }
