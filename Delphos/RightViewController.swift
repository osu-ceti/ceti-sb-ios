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


class RightViewController: UIViewController, UIWebViewDelegate {
    
    enum Menu: Int {
        case Home = 0
        case Settings
        case Profile
        case Logout
        case PushNotification
        
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
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel!.font = UIFont.italicSystemFontOfSize(16)
        cell.textLabel!.textColor = UIColor.blackColor()
        cell.textLabel!.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let menu = Menu(rawValue: indexPath.item) {
            
            switch menu {
            case .Home:
                if(isRegister){
                    rootViewController = gObjLoginController
                    self.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                }
                else{
                    rootViewController = gObjHomeController
                    self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                }
                break
                
            case .Settings:
                self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                break
            case .Profile:
               // self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let testfacade = appDelegate.getObjFacade()
                testfacade.doTask(self,action: DelphosAction.USER_PROFILE)
                
                
                break
            case .Logout:
                //self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let testfacade = appDelegate.getObjFacade()
                testfacade.doTask(self,action: DelphosAction.SIGN_OUT)

                break
            case .PushNotification:

              // self.slideMenuController()?.changeMainViewController(gObjHomeController, close: true)

                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let testfacade = appDelegate.getObjFacade()
                testfacade.doTask(self,action: DelphosAction.HANDLE_NOTIFICATION)
                
                break

            }
        }
    }
   }
