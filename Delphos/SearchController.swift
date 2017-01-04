//
//  SearchController.swift
//  Delphos
//
//  Created by Prabhu on 5/13/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchController: NavController, UITableViewDataSource, UITableViewDelegate {

    var eventDisplayBean: EventDisplayBean!
    var eventBeanArray: [EventBean]! = []
    var usersBeanArray: [userListBean]! = []
    var schoolsDisplayBean: SchoolsDisplayBean!
    var schoolsBeanArray: [SchoolListBean]! = []
    
    @IBOutlet weak var eventFound: UILabel!
    
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = false
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        
        
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewController = self
        //Adding Navbar
//        setNavBar(self.view.frame.size.width)
//        searchBar.delegate = self
//        navigationBar.delegate = self;
//        backToView = "HomeID"
//       
        self.eventFound.isHidden = true
        self.tableVIew.dataSource = self
        tableVIew.delegate = self
        self.tableVIew.tableFooterView = UIView()
        
        self.view.backgroundColor = bgColor
        self.tableVIew.backgroundColor = bgColor
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if(eventBeanArray.count > 0) {
            return eventBeanArray.count
        } else if(usersBeanArray.count > 0) {
            return usersBeanArray.count
            
        } else if (schoolsBeanArray.count > 0){
            return schoolsBeanArray.count
        }
        return 1
    }
    
    func configureCell(_ cell: UITableViewCell,   indexPath: IndexPath)  {
       
        if(eventBeanArray.count > 0) {
           
            let eventDisplayBean: EventBean! = eventBeanArray[(indexPath as NSIndexPath).row]
            //(cell as! SearchControllerCell).startdate.hidden = false
            (cell as! SearchControllerCell).txtTitle!.text = String(eventDisplayBean.event_title)
            (cell as! SearchControllerCell).txtIdHidden!.text = String(eventDisplayBean.id)
            (cell as! SearchControllerCell).startdate!.text = String(eventDisplayBean.event_start)
                  }
        else if(usersBeanArray.count > 0) {
            
            let usersListBean: userListBean! = usersBeanArray[(indexPath as NSIndexPath).row]
            
            (cell as! SearchControllerCell).txtTitle!.text = String(usersListBean.name)
            (cell as! SearchControllerCell).txtIdHidden!.text = String(usersListBean.id)
            (cell as! SearchControllerCell).startdate!.text = usersListBean.association
        }
        else if(schoolsBeanArray.count > 0){
            
            let schoolsDisplayBean: SchoolListBean! = schoolsBeanArray[(indexPath as NSIndexPath).row]
            //(cell as! SearchControllerCell).startdate.hidden = false
            (cell as! SearchControllerCell).txtTitle!.text = String(schoolsDisplayBean.school_name)
            (cell as! SearchControllerCell).txtIdHidden!.text = String(schoolsDisplayBean.id)
            if(schoolsDisplayBean.city_state != nil){
                (cell as! SearchControllerCell).startdate!.text = String(schoolsDisplayBean.city_state)
            }else{
                (cell as! SearchControllerCell).startdate!.text = schoolsDisplayBean.mail_city
            }
        
        
        }
        else{
             cell.backgroundColor = bgColor //UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
           if(gBtnRadioValue == "events") {
             self.eventFound.isHidden = false
            self.tableVIew.isHidden = true
            self.eventFound.text = "No Events Found"
            }
           else if(gBtnRadioValue == "users") {
             self.eventFound.isHidden = false
             self.tableVIew.isHidden = true
             self.eventFound.text = "No Users Found"
            }
           else{
            self.eventFound.isHidden = false
             self.tableVIew.isHidden = true
            self.eventFound.text = "No Schools Found"
            }
            //(cell as! SearchControllerCell).txtTitle.hidden = true
            //(cell as! SearchControllerCell).startdate.hidden = true
        }
        
        
    }
    
    //function to return dynamic cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchId", for: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         showOverlay(self.view)
        let currentCell = tableView.cellForRow(at: indexPath) as! SearchControllerCell
        print("currentCell", currentCell.txtIdHidden.text!)
        
        if(currentCell.txtIdHidden.text != nil){
            gSearchValue = Int(currentCell.txtIdHidden.text!)
        }
        if(schoolsBeanArray.count > 0){
            gSchoolBackBtn = true
        }
        
        DispatchQueue.main.async(execute: {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.show_SEARCH)
        })
     
    }
}
