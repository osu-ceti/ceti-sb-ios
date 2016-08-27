//
//  UserProfileController.swift
//  Delphos
//
//  Created by Babu on 6/13/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//


import UIKit



class UserProfileController:  NavController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
   
    
    @IBOutlet var labelChangeJobTitle: UILabel!
    
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
    
    @IBOutlet var labelNoBadges: UILabel!
   
    
    @IBOutlet var btnProfile: UIButton!
    @IBOutlet var btnBadges: UIButton!
    var bottomLineProfile      = CALayer()
    var bottomLineBadges      = CALayer()
    
    @IBOutlet var btnContactUser: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var eventDisplayBean: usersBean!
    var eventBeanArray: [EventBean]! = []
    var usersBeanArray: [userListBean]! = []
    var userProfileBadgesArray:[UserProfileBadgesBean]! = []
    
    var schoolProfileId:Int!
    var tempBackToViewController:UIViewController!
    var imagesCount:Int!
    
    var profileButtonColor = UIColor(hue: 0.4528, saturation: 0.65, brightness: 0.63, alpha: 1.0).CGColor
    
      override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // self.showOverlay(self.view)
        //rootViewController = self
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        

        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.showOverlay(self.view)
        if(tempBackToViewController != nil){
            gObjBackTocontroller = tempBackToViewController
            tempBackToViewController = nil
        }
        
        //Adding Navbar
        rootViewController = self
        self.isBackEnabled = false
        imagesCount = userProfileBadgesArray.count
        
        self.labelChangeJobTitle.hidden = true
        
        
        
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        // navigationBar.delegate = self;
        //backToView = "HomeID"
        
        self.collectionView.hidden = true
        gUserProfileMessage = false
        gSchoolNameSelect = false
        
        self.labelNoBadges.hidden = true
        
        self.tableView.dataSource = self
        tableView.delegate = self
        self.view.backgroundColor = bgColor
        collectionView.backgroundColor = bgColor
        collectionView.dataSource = self
        
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
        labelEventFeed.font = UIFont.boldSystemFontOfSize(15)
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
        
        gSearchUserProfile = gObjSearchUserListBean.id
       
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
            
           self.labelChangeJobTitle.hidden = false
           
            self.labelSchool.text   = "Job Title:"
            self.labelGrades.text   = "Business:"
            self.labelJobTitle.text = "Role:"
            self.labelBusiness.text = "Biography:"
            
            self.labelSchool.hidden   = false
            labelChangeJobTitle.text = gObjSearchUserListBean.job_title
            self.labelGrades.hidden   = false
            self.btnLinkSchool.hidden = true
            self.txtGrades.hidden = false
            self.txtGrades.text = gObjSearchUserListBean.business
            
            self.labelJobTitle.hidden = false
            self.labelJobTitle.text = gObjSearchUserListBean.role
            
            self.txtBusiness!.hidden = false
            self.txtBusiness!.text = gObjSearchUserListBean.biography
            
           
            
            self.txtJobTitle.hidden = false
            self.txtBusiness!.hidden = false
            
            self.labelRole.hidden = true
            self.labelBiography.hidden = true
            self.txtRole!.hidden = true
            self.txtBiography.hidden = true
            
            
            
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
            self.labelChangeJobTitle.hidden = true

        
        
        }
        bottomLineProfile.frame = CGRectMake(0, btnProfile.frame.size.height, btnProfile.frame.size.width, 1)
        bottomLineProfile.borderWidth = 2.0
        bottomLineProfile.borderColor = profileButtonColor;        btnProfile.layer.addSublayer(bottomLineProfile)

        
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
        
        tempBackToViewController = gObjBackTocontroller
        gObjBackTocontroller = gObjUserProfileNavController
       
        dispatch_async(dispatch_get_main_queue(), {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_EVENT)
        })
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (userProfileBadgesArray.count > 0){
            return userProfileBadgesArray.count
        }
        else{
            self.hideOverlayView()
            
            return 0
            
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BdgeCellId", forIndexPath: indexPath) as! BadgeCollectionViewCell
        imagesCount = imagesCount-1
        
        if (userProfileBadgesArray.count > 0){
            self.labelNoBadges.hidden = true
            
           dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            

                cell.backgroundColor = UIColor.whiteColor()
                let imageDisplayBean: UserProfileBadgesBean = self.userProfileBadgesArray[indexPath.row]
            
                if let url = NSURL(string:AWS_S3 + imageDisplayBean.badge_url){
                    dispatch_async(dispatch_get_main_queue(), {

                        let badgesImage = NSData(contentsOfURL:url)
            
                
                        cell.imgUserBadge.image = UIImage(data:badgesImage!)
                        cell.badgeId.text = String(imageDisplayBean.badge_id)
                })
            }
                 
            })
        }
        
        if(imagesCount == 0){
            dispatch_async(dispatch_get_main_queue(), {
                
                self.hideOverlayView()
                
            })
            
        }
        
        return cell
        
        
    }
    
    
    
    
    
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                        
//                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> Void {
//        //CGSize(width: 50, height: 40)
//
//        
//        return
//    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        
        
        var selectCell = collectionView.cellForItemAtIndexPath(indexPath) as! BadgeCollectionViewCell
        
        //selectCell.backgroundColor = UIColor.blueColor()
        
        print("select", selectCell.badgeId.text!)
        gBadgeid = Int(selectCell.badgeId.text!)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.SHOW_SHARE_BADGE)
    }
    
    
    
    
    @IBAction func btnProfileClick(sender: AnyObject) {
   
        
        bottomLineProfile.frame = CGRectMake(0, btnProfile.frame.size.height, btnProfile.frame.size.width, 1)
        bottomLineProfile.borderWidth = 2.0
        
        
        bottomLineProfile.borderColor = profileButtonColor
        btnProfile.layer.addSublayer(bottomLineProfile)
       // self.tableView.center =
        bottomLineBadges.borderColor = UIColor.clearColor().CGColor
        
        self.collectionView.hidden = true
        self.labelNoBadges.hidden = true        
        
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
            
            self.labelSchool.hidden   = false
            self.labelGrades.hidden   = false
            self.labelJobTitle.hidden = false
            self.labelBusiness.hidden = false
            
            self.btnLinkSchool.hidden = false
            self.txtGrades.hidden = false
            self.txtJobTitle.hidden = false
            self.txtBusiness!.hidden = false
            self.labelChangeJobTitle.hidden = true

            
        }
        else if(gObjSearchUserListBean.role == "Speaker"){
            
            self.labelChangeJobTitle.hidden = false
            
            self.labelSchool.text   = "Job Title:"
            self.labelGrades.text   = "Business:"
            self.labelJobTitle.text = "Role:"
            self.labelBusiness.text = "Biography:"
            
            self.labelBusiness.hidden = false
            self.labelSchool.hidden   = false
            labelChangeJobTitle.text = gObjSearchUserListBean.job_title
            self.labelGrades.hidden   = false
            self.btnLinkSchool.hidden = true
            self.txtGrades.hidden = false
            self.txtGrades.text = gObjSearchUserListBean.business
            
            self.labelJobTitle.hidden = false
            self.labelJobTitle.text = gObjSearchUserListBean.role
            
            self.txtBusiness!.hidden = false
            self.txtBusiness!.text = gObjSearchUserListBean.biography
            
            
            
            self.txtJobTitle.hidden = false
            self.txtBusiness!.hidden = false
            
            self.labelRole.hidden = true
            self.labelBiography.hidden = true
            self.txtRole!.hidden = true
            self.txtBiography.hidden = true
            

            
            
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
            
            self.labelRole.hidden = false
            self.labelBiography.hidden = false
            
            self.txtRole!.hidden = false
            self.txtBiography.hidden = false


        }

    }
    @IBAction func btnBadges(sender: AnyObject) {
        
        
        bottomLineBadges.frame = CGRectMake(0, btnBadges.frame.size.height, btnBadges.frame.size.width, 1)
        bottomLineBadges.borderWidth = 2.0
        
        
        bottomLineBadges.borderColor = profileButtonColor
        btnBadges.layer.addSublayer(bottomLineBadges)
        bottomLineProfile.borderColor = UIColor.clearColor().CGColor
        
        if (userProfileBadgesArray.count > 0){
            
            self.labelNoBadges.hidden = true
        }
        else{
            self.labelNoBadges.hidden = false
             self.labelNoBadges.text = gObjSearchUserListBean.name + " has not earned any Badges"
            
        }

        self.collectionView.hidden = false
        
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
        
        self.labelChangeJobTitle.hidden = true
        
      
        
        
    }

    @IBAction func btnSchoolNameClick(sender: AnyObject) {
        
        if(gObjSearchUserListBean.school_id != 1){
            showOverlay(self.view)
            gSchoolNameSelect = true
        
            gSchoolId = gObjSearchUserListBean.school_id
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.SHOW_SCHOOL_PROFILE)
        }
        else{
            self.searchBar.hidden = false
            navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItems = [menuButton,searchButton]
            searchBar.sizeToFit()
            searchBar.becomeFirstResponder()
            searchBar.showsCancelButton = true
            
            
            //navigationBar.items = [navigationItem]
            searchView.hidden = false
            segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
                segmentSearchItems.selectedSegmentIndex = 1
            gBtnRadioValue = "schools"

        
        }
        
    }
    
    @IBAction func btnContactUserClick(sender: AnyObject) {
   
        gUserProfileMessage = true

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.VIEW_MESSAGE_CONTROLLER)
    
}
    
    
    
    
    
    
    
    
    
    
    
}
