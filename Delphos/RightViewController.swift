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
    }
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Home", "Settings", "Profile", "Logout"]
    
    var homeController: UIViewController!
    
    convenience init() {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let homeController = storyboard.instantiateViewControllerWithIdentifier("HomeID") as! HomeController
        self.homeController = UINavigationController(rootViewController: homeController)
       
        
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
                self.slideMenuController()?.changeMainViewController(self.homeController, close: true)
                break
            case .Settings:
                self.slideMenuController()?.changeMainViewController(self.homeController, close: true)
                break
            case .Profile:
                self.slideMenuController()?.changeMainViewController(self.homeController, close: true)
                break
            case .Logout:
                self.slideMenuController()?.changeMainViewController(self.homeController, close: true)
                break
             default:break
                
            }
        }
    }
   }
