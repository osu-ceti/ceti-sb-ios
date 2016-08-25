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
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        self.labelChangeJobTitle.isHidden = true
        
        
        
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        // navigationBar.delegate = self;
        //backToView = "HomeID"
        
        self.collectionView.isHidden = true
        gUserProfileMessage = false
        gSchoolNameSelect = false
        
        self.labelNoBadges.isHidden = true
        
        self.tableView.dataSource = self
        tableView.delegate = self
        //var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        collectionView.backgroundColor = bgColor
        collectionView.dataSource = self
        
        self.labelNoEventFound.isHidden = true
        self.tableView.backgroundColor = bgColor
        self.tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        
        txtUserName.font =  UIFont.boldSystemFont(ofSize: 15)
        labelSchool.font = UIFont.boldSystemFont(ofSize: 15)
        labelGrades.font = UIFont.boldSystemFont(ofSize: 15)
        labelJobTitle.font = UIFont.boldSystemFont(ofSize: 15)
        labelBusiness.font = UIFont.boldSystemFont(ofSize: 15)
        labelRole.font = UIFont.boldSystemFont(ofSize: 15)
        labelBiography.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.labelSchool.text   = "School:"
        self.labelGrades.text   = "Grades:"
        self.labelJobTitle.text = "JobTitle:"
        self.labelBusiness.text = "Business:"
        self.labelRole.text     = "Role:"
        self.labelBiography.text = "Biography:"
        
        self.txtUserName.text     = gObjSearchUserListBean.name
        btnLinkSchool.setTitle( gObjSearchUserListBean.school_name, for: UIControlState())
        
        self.txtGrades.text       = gObjSearchUserListBean.grades
        self.txtJobTitle.text     = gObjSearchUserListBean.job_title
        self.txtBusiness!.text    = gObjSearchUserListBean.business
        self.txtRole!.text        = gObjSearchUserListBean.role
        self.txtBiography.text    = gObjSearchUserListBean.biography
        
        gSearchUserProfile = gObjSearchUserListBean.id
       
        if(gObjUserBean.id == gObjSearchUserListBean.id){
            
            self.btnContactUser.isHidden = true
            
        }
        else{
            
            self.btnContactUser.isHidden = false
        }
        
        if(gObjSearchUserListBean.role == "Teacher"){
           
           
            
            self.labelSchool.text   = "School:"
            self.labelGrades.text   = "Grades:"
            self.labelJobTitle.text = "Role:"
            self.labelBusiness.text = "Biography:"
            self.labelRole.isHidden     = true
            self.labelBiography.isHidden = true
            
            
            self.txtJobTitle.text       = gObjSearchUserListBean.role
            self.txtBusiness!.text      = gObjSearchUserListBean.biography
            self.txtRole!.isHidden        = true
            self.txtBiography.isHidden    = true
           
           
            
           
        }
        else  if(gObjSearchUserListBean.role == "Speaker"){
            
           self.labelChangeJobTitle.isHidden = false
           
            self.labelSchool.text   = "Job Title:"
            self.labelGrades.text   = "Business:"
            self.labelJobTitle.text = "Role:"
            self.labelBusiness.text = "Biography:"
            
            self.labelSchool.isHidden   = false
            labelChangeJobTitle.text = gObjSearchUserListBean.job_title
            self.labelGrades.isHidden   = false
            self.btnLinkSchool.isHidden = true
            self.txtGrades.isHidden = false
            self.txtGrades.text = gObjSearchUserListBean.business
            
            self.labelJobTitle.isHidden = false
            self.labelJobTitle.text = gObjSearchUserListBean.role
            
            self.txtBusiness!.isHidden = false
            self.txtBusiness!.text = gObjSearchUserListBean.biography
            
           
            
            self.txtJobTitle.isHidden = false
            self.txtBusiness!.isHidden = false
            
            self.labelRole.isHidden = true
            self.labelBiography.isHidden = true
            self.txtRole!.isHidden = true
            self.txtBiography.isHidden = true
            
            
            
        }
        else{
            self.txtJobTitle.isHidden = false
            self.txtBusiness!.isHidden = false
            self.labelJobTitle.isHidden = false
            self.labelBusiness.isHidden = false
            
            self.labelSchool.isHidden   = false
            self.labelGrades.isHidden   = false
            self.btnLinkSchool.isHidden = false
            self.txtGrades.isHidden = false
            self.labelChangeJobTitle.isHidden = true

        
        
        }
        bottomLineProfile.frame = CGRect(x: 0, y: btnProfile.frame.size.height - 1.0, width: btnProfile.frame.size.width, height: 1)
        bottomLineProfile.borderWidth = 2.0
        bottomLineProfile.borderColor = UIColor(hue: 0.3194, saturation: 1, brightness: 0.24, alpha: 1.0) /* #053d00  */.cgColor /* #559369  */
        btnProfile.layer.addSublayer(bottomLineProfile)

        
    }

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if(eventBeanArray!.count > 0){
            return eventBeanArray!.count
            }
        else{
            return 1
        }
        
    }
    
    func configureCell(_ cell: UITableViewCell,   indexPath: IndexPath)  {
        
        
         if(eventBeanArray!.count > 0){
            
            self.tableView.isHidden = false
            let eventDisplayBean: EventBean! = eventBeanArray[(indexPath as NSIndexPath).row]
        
        
            (cell as! UserProfileCell).eventTitle!.text = String(eventDisplayBean.event_title)
            (cell as! UserProfileCell).eventStartDate!.text = String(eventDisplayBean.event_start)
            (cell as! UserProfileCell).eventId!.text =  String(eventDisplayBean.id)
        }
         else{
           
            self.tableView.isHidden = true
            self.labelNoEventFound.isHidden = false
        }
    }
    
    //function to return dynamic cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userProfileCell", for: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    //function to respond to row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectCell = tableView.cellForRow(at: indexPath) as! UserProfileCell
        print("currentCell", selectCell.eventId.text!)
        
        gEventID = Int(selectCell.eventId.text!)
        
        tempBackToViewController = gObjBackTocontroller
        gObjBackTocontroller = gObjUserProfileNavController
       
        DispatchQueue.main.async(execute: {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.show_EVENT)
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (userProfileBadgesArray.count > 0){
            return userProfileBadgesArray.count
        }
        else{
            self.hideOverlayView()
            
            return 0
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BdgeCellId", for: indexPath) as! BadgeCollectionViewCell
        imagesCount = imagesCount-1
        
        if (userProfileBadgesArray.count > 0){
            self.labelNoBadges.isHidden = true
            
           DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            
            

                cell.backgroundColor = UIColor.white
                let imageDisplayBean: UserProfileBadgesBean = self.userProfileBadgesArray[(indexPath as NSIndexPath).row]
            
                if let url = URL(string:AWS_S3 + imageDisplayBean.badge_url){
                    DispatchQueue.main.async(execute: {

                        let badgesImage = try? Data(contentsOf: url)
            
                
                        cell.imgUserBadge.image = UIImage(data:badgesImage!)
                        cell.badgeId.text = String(imageDisplayBean.badge_id)
                })
            }
                 
            })
        }
        
        if(imagesCount == 0){
            DispatchQueue.main.async(execute: {
                
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
    
    func collectionView(_ collectionView: UICollectionView!, didSelectItemAt indexPath: IndexPath)
    {
        
        
        var selectCell = collectionView.cellForItem(at: indexPath) as! BadgeCollectionViewCell
        
        //selectCell.backgroundColor = UIColor.blueColor()
        
        print("select", selectCell.badgeId.text!)
        gBadgeid = Int(selectCell.badgeId.text!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.show_SHARE_BADGE)
    }
    
    
    
    
    @IBAction func btnProfileClick(_ sender: AnyObject) {
   
        
        bottomLineProfile.frame = CGRect(x: 0, y: btnProfile.frame.size.height - 1.0, width: btnProfile.frame.size.width, height: 1)
        bottomLineProfile.borderWidth = 2.0
        bottomLineProfile.borderColor = UIColor(hue: 0.3194, saturation: 1, brightness: 0.24, alpha: 1.0) /* #053d00  */.cgColor /* #559369  */
        btnProfile.layer.addSublayer(bottomLineProfile)
       // self.tableView.center =
        bottomLineBadges.borderColor = UIColor.clear.cgColor
        
        self.collectionView.isHidden = true
        self.labelNoBadges.isHidden = true        
        
        if(gObjSearchUserListBean.role == "Teacher"){
            
            self.labelSchool.text   = "School:"
            self.labelGrades.text   = "Grades:"
            self.labelJobTitle.text = "Role:"
            self.labelBusiness.text = "Biography:"
            self.labelRole.isHidden     = true
            self.labelBiography.isHidden = true
            
            
            self.txtJobTitle.text       = gObjSearchUserListBean.role
            self.txtBusiness!.text      = gObjSearchUserListBean.biography
            self.txtRole!.isHidden        = true
            self.txtBiography.isHidden    = true
            
            self.labelSchool.isHidden   = false
            self.labelGrades.isHidden   = false
            self.labelJobTitle.isHidden = false
            self.labelBusiness.isHidden = false
            
            self.btnLinkSchool.isHidden = false
            self.txtGrades.isHidden = false
            self.txtJobTitle.isHidden = false
            self.txtBusiness!.isHidden = false
            self.labelChangeJobTitle.isHidden = true

            
        }
        else if(gObjSearchUserListBean.role == "Speaker"){
            
            self.labelChangeJobTitle.isHidden = false
            
            self.labelSchool.text   = "Job Title:"
            self.labelGrades.text   = "Business:"
            self.labelJobTitle.text = "Role:"
            self.labelBusiness.text = "Biography:"
            
            self.labelBusiness.isHidden = false
            self.labelSchool.isHidden   = false
            labelChangeJobTitle.text = gObjSearchUserListBean.job_title
            self.labelGrades.isHidden   = false
            self.btnLinkSchool.isHidden = true
            self.txtGrades.isHidden = false
            self.txtGrades.text = gObjSearchUserListBean.business
            
            self.labelJobTitle.isHidden = false
            self.labelJobTitle.text = gObjSearchUserListBean.role
            
            self.txtBusiness!.isHidden = false
            self.txtBusiness!.text = gObjSearchUserListBean.biography
            
            
            
            self.txtJobTitle.isHidden = false
            self.txtBusiness!.isHidden = false
            
            self.labelRole.isHidden = true
            self.labelBiography.isHidden = true
            self.txtRole!.isHidden = true
            self.txtBiography.isHidden = true
            

            
            
        }
        else{
            self.txtJobTitle.isHidden = false
            self.txtBusiness!.isHidden = false
            self.labelJobTitle.isHidden = false
            self.labelBusiness.isHidden = false
            
            self.labelSchool.isHidden   = false
            self.labelGrades.isHidden   = false
            self.btnLinkSchool.isHidden = false
            self.txtGrades.isHidden = false
            
            self.labelRole.isHidden = false
            self.labelBiography.isHidden = false
            
            self.txtRole!.isHidden = false
            self.txtBiography.isHidden = false


        }

    }
    @IBAction func btnBadges(_ sender: AnyObject) {
        
        
        bottomLineBadges.frame = CGRect(x: 0, y: btnBadges.frame.size.height - 1.0, width: btnBadges.frame.size.width, height: 1)
        bottomLineBadges.borderWidth = 2.0
        bottomLineBadges.borderColor = UIColor(hue: 0.3194, saturation: 1, brightness: 0.24, alpha: 1.0) /* #053d00  */.cgColor /* #559369  */
        btnBadges.layer.addSublayer(bottomLineBadges)
        bottomLineProfile.borderColor = UIColor.clear.cgColor
        
        if (userProfileBadgesArray.count > 0){
            
            self.labelNoBadges.isHidden = true
        }
        else{
            self.labelNoBadges.isHidden = false
             self.labelNoBadges.text = gObjSearchUserListBean.name + " has not earned any Badges"
            
        }

        self.collectionView.isHidden = false
        
        self.labelSchool.isHidden = true
        self.labelGrades.isHidden = true
        self.labelJobTitle.isHidden = true
        self.labelBusiness.isHidden = true
        self.labelRole.isHidden = true
        self.labelBiography.isHidden = true
        
        self.btnLinkSchool.isHidden = true
        self.txtGrades.isHidden = true
        self.txtJobTitle.isHidden = true
        self.txtBusiness!.isHidden = true
        self.txtRole!.isHidden = true
        self.txtBiography.isHidden = true
        
        self.labelChangeJobTitle.isHidden = true
        
      
        
        
    }

    @IBAction func btnSchoolNameClick(_ sender: AnyObject) {
        
        if(gObjSearchUserListBean.school_id != 1){
            showOverlay(self.view)
            gSchoolNameSelect = true
        
            gSchoolId = gObjSearchUserListBean.school_id
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.show_SCHOOL_PROFILE)
        }
        else{
            self.searchBar.isHidden = false
            navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItems = [menuButton,searchButton]
            searchBar.sizeToFit()
            searchBar.becomeFirstResponder()
            searchBar.showsCancelButton = true
            
            
            //navigationBar.items = [navigationItem]
            searchView.isHidden = false
            segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
                segmentSearchItems.selectedSegmentIndex = 1
            gBtnRadioValue = "schools"

        
        }
        
    }
    
    @IBAction func btnContactUserClick(_ sender: AnyObject) {
   
        gUserProfileMessage = true

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.view_MESSAGE_CONTROLLER)
    
}
    
    
    
    
    
    
    
    
    
    
    
}
