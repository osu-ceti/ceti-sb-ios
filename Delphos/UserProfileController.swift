//
//  UserProfileController.swift
//  Delphos
//
//  Created by Babu on 6/13/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//


import UIKit



class UserProfileController:  NavController, UITableViewDataSource, UITableViewDelegate{
    
   
    
    
    @IBOutlet var labelNoEventFound: UILabel!
    @IBOutlet weak var labelSchool: UILabel!
    @IBOutlet weak var labelGrades: UILabel!
    @IBOutlet weak var labelJobTitle: UILabel!
    @IBOutlet weak var labelBusiness: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelBiography: UILabel!
    
    
    @IBOutlet var lineView: UIView!
    @IBOutlet var labelEventFeed: UILabel!
    
    @IBOutlet weak var txtSchool: UILabel!
    @IBOutlet weak var txtGrades: UILabel!
    @IBOutlet weak var txtJobTitle: UILabel!
    @IBOutlet weak var txtBusiness: UILabel?
    @IBOutlet weak var txtRole: UILabel?
    @IBOutlet weak var txtBiography: UILabel!
    
    @IBOutlet weak var txtUserName: UILabel!
    
    @IBOutlet var btnLinkSchool: UIButton!
      
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var btnProfile: UIButton!
    @IBOutlet var btnBadges: UIButton!
    var bottomLineProfile      = CALayer()
    var bottomLineBadges      = CALayer()
    
    @IBOutlet var btnContactUser: UIButton!
    
    
    var eventDisplayBean: usersBean!
    var eventBeanArray: [EventBean]! = []
    var usersBeanArray: [userListBean]! = []
    
    
    
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
        
        //Adding Navbar
        self.isBackEnabled = true
        
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        // navigationBar.delegate = self;
        //backToView = "HomeID"
      
        gUserProfileMessage = false
        gSchoolNameSelect = false
        
        
        self.tableView.dataSource = self
        tableView.delegate = self
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        self.labelNoEventFound.hidden = true
        self.tableView.backgroundColor = bgColor
        self.tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        
        txtUserName.font =  UIFont.boldSystemFontOfSize(15)
        labelSchool.font = UIFont.boldSystemFontOfSize(15)
        labelGrades.font = UIFont.boldSystemFontOfSize(15)
        labelJobTitle.font = UIFont.boldSystemFontOfSize(15)
        labelBusiness.font = UIFont.boldSystemFontOfSize(15)
        labelRole.font = UIFont.boldSystemFontOfSize(15)
        labelBiography.font = UIFont.boldSystemFontOfSize(15)
        
        self.labelSchool.text   = "School:"
        self.labelGrades.text   = "Grades:"
        self.labelJobTitle.text = "JobTitle:"
        self.labelBusiness.text = "Business:"
        self.labelRole.text     = "Role:"
        self.labelBiography.text = "Biography:"
        
        self.txtUserName.text     = gObjSearchUserListBean.name
        btnLinkSchool.setTitle( gObjSearchUserListBean.school_name, forState: .Normal)
        
        self.txtGrades.text       = gObjSearchUserListBean.grades
        self.txtJobTitle.text     = gObjSearchUserListBean.job_title
        self.txtBusiness!.text    = gObjSearchUserListBean.business
        self.txtRole!.text        = gObjSearchUserListBean.role
        self.txtBiography.text    = gObjSearchUserListBean.biography
       
        if(gObjUserBean.id == gObjSearchUserListBean.id){
            
            self.btnContactUser.hidden = true
            
        }
        else{
            
            self.btnContactUser.hidden = false
        }
        
        if(gObjSearchUserListBean.role == "Teacher"){
            self.labelSchool.text   = "School:"
            self.labelGrades.text   = "Grades:"
            self.labelJobTitle.text = "Role:"
            self.labelBusiness.text = "Biography:"
            self.labelRole.hidden     = true
            self.labelBiography.hidden = true
            
            
            self.txtJobTitle.text       = gObjSearchUserListBean.role
            self.txtBusiness!.text      = gObjSearchUserListBean.biography
            self.txtRole!.hidden        = true
            self.txtBiography.hidden    = true
           
            
           
        }
        else  if(gObjSearchUserListBean.role == "Speaker"){
           
            self.labelSchool.hidden   = true
            self.labelGrades.hidden   = true
            self.btnLinkSchool.hidden = true
            self.txtGrades.hidden = true
            
            
            
        }
        else{
            self.txtJobTitle.hidden = false
            self.txtBusiness!.hidden = false
            self.labelJobTitle.hidden = false
            self.labelBusiness.hidden = false
            
            self.labelSchool.hidden   = false
            self.labelGrades.hidden   = false
            self.btnLinkSchool.hidden = false
            self.txtGrades.hidden = false

        
        
        }
        bottomLineProfile.frame = CGRectMake(0, btnProfile.frame.size.height - 1.0, btnProfile.frame.size.width, 1)
        bottomLineProfile.borderWidth = 2.0
        bottomLineProfile.borderColor = UIColor(hue: 0.3194, saturation: 1, brightness: 0.24, alpha: 1.0) /* #053d00  */.CGColor /* #559369  */
        btnProfile.layer.addSublayer(bottomLineProfile)

        
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
        if(eventBeanArray!.count > 0){
            return eventBeanArray!.count
            }
        else{
            return 1
        }
        
    }
    
    func configureCell(cell: UITableViewCell,   indexPath: NSIndexPath)  {
        
        
         if(eventBeanArray!.count > 0){
            
            self.tableView.hidden = false
            var eventDisplayBean: EventBean! = eventBeanArray[indexPath.row]
        
        
            (cell as! UserProfileCell).eventTitle!.text = String(eventDisplayBean.event_title)
            (cell as! UserProfileCell).eventStartDate!.text = String(eventDisplayBean.event_start)
            (cell as! UserProfileCell).eventId!.text =  String(eventDisplayBean.id)
        }
         else{
           
            self.tableView.hidden = true
            self.labelNoEventFound.hidden = false
        }
    }
    
    //function to return dynamic cell
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userProfileCell", forIndexPath: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectCell = tableView.cellForRowAtIndexPath(indexPath) as! UserProfileCell
        print("currentCell", selectCell.eventId.text!)
        
        gEventID = Int(selectCell.eventId.text!)
        dispatch_async(dispatch_get_main_queue(), {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_EVENT)
        })
    }
    

    
    
    
    
    @IBAction func btnProfileClick(sender: AnyObject) {
   
        
        bottomLineProfile.frame = CGRectMake(0, btnProfile.frame.size.height - 1.0, btnProfile.frame.size.width, 1)
        bottomLineProfile.borderWidth = 2.0
        bottomLineProfile.borderColor = UIColor(hue: 0.3194, saturation: 1, brightness: 0.24, alpha: 1.0) /* #053d00  */.CGColor /* #559369  */
        btnProfile.layer.addSublayer(bottomLineProfile)
       // self.tableView.center =
        bottomLineBadges.borderColor = UIColor.clearColor().CGColor

        self.labelSchool.hidden = false
        self.labelGrades.hidden = false
        self.labelJobTitle.hidden = false
        self.labelBusiness.hidden = false
        self.labelRole.hidden = false
        self.labelBiography.hidden = false
        
        self.btnLinkSchool.hidden = false
        self.txtGrades.hidden = false
        self.txtJobTitle.hidden = false
        self.txtBusiness!.hidden = false
        self.txtRole!.hidden = false
        self.txtBiography.hidden = false
        
//        self.btnContactUser.center = CGPointMake(160, 370 )
//        self.lineView.center = CGPointMake( 160, 410 )
//        self.labelEventFeed.center = CGPointMake(160,390 )
//        self.tableView.center = CGPointMake(160, 500)
        
    }
    @IBAction func btnBadges(sender: AnyObject) {
        
        bottomLineBadges.frame = CGRectMake(0, btnBadges.frame.size.height - 1.0, btnBadges.frame.size.width, 1)
        bottomLineBadges.borderWidth = 2.0
        bottomLineBadges.borderColor = UIColor(hue: 0.3194, saturation: 1, brightness: 0.24, alpha: 1.0) /* #053d00  */.CGColor /* #559369  */
        btnBadges.layer.addSublayer(bottomLineBadges)
        bottomLineProfile.borderColor = UIColor.clearColor().CGColor
        
        
        self.labelSchool.hidden = true
        self.labelGrades.hidden = true
        self.labelJobTitle.hidden = true
        self.labelBusiness.hidden = true
        self.labelRole.hidden = true
        self.labelBiography.hidden = true
        
        self.btnLinkSchool.hidden = true
        self.txtGrades.hidden = true
        self.txtJobTitle.hidden = true
        self.txtBusiness!.hidden = true
        self.txtRole!.hidden = true
        self.txtBiography.hidden = true
        
//        self.btnContactUser.center = CGPointMake(160, 160 )
//        self.labelEventFeed.center = CGPointMake(160, 180 )
//        self.tableView.center = CGPointMake(160, 280)
//        self.lineView.center = CGPointMake( 160, 190 )
        
        
    }

    @IBAction func btnSchoolNameClick(sender: AnyObject) {
         showOverlay(self.view)
         gSchoolNameSelect = true
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SHOW_SCHOOL_PROFILE)

    }
    
    @IBAction func btnContactUserClick(sender: AnyObject) {
   
        gUserProfileMessage = true

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.VIEW_MESSAGE_CONTROLLER)
    }
}
