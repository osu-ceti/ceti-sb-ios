//
//  SchoolProfileController.swift
//  Delphos
//
//  Created by Babu on 6/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//


import UIKit



class SchoolProfileController:  NavController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet var schoolNameLabel: UILabel!
    
    
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var labelCity: UILabel!
    @IBOutlet var labelState: UILabel!
    @IBOutlet var labelZip: UILabel!
    @IBOutlet var labelPhone: UILabel!
    
    
    
    @IBOutlet var txtAddress: UILabel!
    @IBOutlet var txtCity: UILabel!
    @IBOutlet var txtState: UILabel!
    @IBOutlet var txtZip: UILabel!
    @IBOutlet var txtPhone: UILabel!
    
    @IBOutlet var schoolImage: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    var eventDisplayBean: usersBean!
    var eventBeanArray: [EventBean]! = []
   
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = true
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        schoolImage.image = UIImage(named:"gObjSchoolImage")
        self.schoolNameLabel.text = gObjSearchSchoolListBean.name
        
        self.labelAddress.text = "Address:"
        self.labelCity.text =   "City:"
        self.labelState.text = "State:"
        self.labelZip.text = "Zip:"
        self.labelPhone.text = "Phone:"

        self.txtAddress.text = gObjSearchSchoolListBean.address
        self.txtCity.text = gObjSearchSchoolListBean.city
        self.txtState.text = gObjSearchSchoolListBean.state
        self.txtZip.text = gObjSearchSchoolListBean.zip
        self.txtPhone.text = gObjSearchSchoolListBean.phone
        
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return eventBeanArray!.count
        // claimBeanArray!.count
        
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
        
        var eventDisplayBean: EventBean! = eventBeanArray[indexPath.row]
        
        
        (cell as! SchoolProfileCell).eventTitle!.text = String(eventDisplayBean.event_title)
        (cell as! SchoolProfileCell).eventStartDate!.text = String(eventDisplayBean.event_start)
        (cell as! SchoolProfileCell).eventId!.text =  String(eventDisplayBean.id)
    }
    
    //function to return dynamic cell
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("schoolProfileCell", forIndexPath: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    //function to respond to row selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectCell = tableView.cellForRowAtIndexPath(indexPath) as! SchoolProfileCell
        print("currentCell", selectCell.eventId.text!)
        
        gEventID = Int(selectCell.eventId.text!)
        dispatch_async(dispatch_get_main_queue(), {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_EVENT)
        })
    }
    

    
    @IBAction func makeMySchoolClick(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SHOW_MAKE_MY_SCHOOL)
        
    }
    
    
    
}

  