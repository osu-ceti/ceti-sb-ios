//
//  PublicProfileController.swift
//  Delphos
//
//  Created by Babu on 6/21/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//


import UIKit



class PublicProfileController:  NavController{
    
    
    
    
    @IBOutlet var labelProfileName: UILabel!
    @IBOutlet var labelProfileSchool: UILabel!
    
    @IBOutlet var labelProfileGrades: UILabel!
    @IBOutlet var labelProfileBiography: UILabel!
    @IBOutlet var labelProfileJobTitle: UILabel!
    @IBOutlet var labelProfileBusiness: UILabel!
    
    @IBOutlet var labelProfileEmail: UILabel!
    @IBOutlet var labelProfileRole: UILabel!
    
    @IBOutlet var txtProfileId: UITextField!
    @IBOutlet var txtProfileGrades: UITextField!
    @IBOutlet var txtProfileBiography: UITextField!
    @IBOutlet var txtProfileJobTItle: UITextField!   
    @IBOutlet var txtProfileBusiness: UITextField!
   
   
    @IBOutlet var hideLabelAccountSetting: UILabel!
    @IBOutlet var hideLabelPublicProfile: UILabel!
    @IBOutlet var hideLabelName: UILabel!
    @IBOutlet var hideLabelGrades: UILabel!
    @IBOutlet var hideLabelSchool: UILabel!
    @IBOutlet var hideLabelJobTitle: UILabel!
    @IBOutlet var hideLabelBusiness: UILabel!
    @IBOutlet var hideLabelBio: UILabel!
    @IBOutlet var hideLabelRole: UILabel!
    @IBOutlet var hideLabelEmail: UILabel!
    
    @IBOutlet var btnSaveProfile: UIButton!
    @IBOutlet var btnFindMySchool: UIButton!
    @IBOutlet var btnEditProfile: UIButton!
    @IBOutlet var btnEditAccount: UIButton!
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    var userProfileBean: UserBean!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        rootViewController = self
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
        
          hideLabelAccountSetting.font = UIFont.boldSystemFontOfSize(15)
          hideLabelPublicProfile.font = UIFont.boldSystemFontOfSize(15)
          hideLabelName.font = UIFont.boldSystemFontOfSize(15)
          hideLabelGrades.font = UIFont.boldSystemFontOfSize(15)
          hideLabelSchool.font = UIFont.boldSystemFontOfSize(15)
          hideLabelJobTitle.font = UIFont.boldSystemFontOfSize(15)
          hideLabelBusiness.font = UIFont.boldSystemFontOfSize(15)
          hideLabelBio.font = UIFont.boldSystemFontOfSize(15)
          hideLabelRole.font = UIFont.boldSystemFontOfSize(15)
          hideLabelEmail.font = UIFont.boldSystemFontOfSize(15)
        
         self.txtProfileGrades.hidden = true
         self.txtProfileBiography.hidden = true
         self.txtProfileJobTItle.hidden = true
         self.txtProfileBusiness.hidden = true
        
         self.btnSaveProfile.hidden = true
         self.btnFindMySchool.hidden = true
        
         self.btnEditProfile.hidden = false
         self.btnEditAccount.hidden = false
//
//        if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.SPEAKER){
//           
//            self.labelProfileSchool.hidden = true
//            self.labelProfileGrades.hidden = true
//            self.hideLabelGrades.hidden = true
//            self.hideLabelSchool.hidden = true
//            self.txtProfileGrades.hidden = true
//            
//        
//        }
//        else{
//            self.labelProfileSchool.hidden = false
//            self.labelProfileGrades.hidden = false
//            self.hideLabelGrades.hidden = false
//            self.hideLabelSchool.hidden = false
//            self.txtProfileGrades.hidden = false
//        
//        }
        
        
        if (userProfileBean != nil){
         self.labelProfileName.text = userProfileBean.name
         self.labelProfileSchool.text = userProfileBean.school_name
            
         self.labelProfileGrades.text = userProfileBean.grades
         self.labelProfileBiography.text = userProfileBean.biography
         self.labelProfileJobTitle.text = userProfileBean.job_title
         self.labelProfileBusiness.text = userProfileBean.business
        
         self.labelProfileEmail.text = userProfileBean.email
            if (userProfileBean.role == 1){
            self.labelProfileRole.text = "TEACHER"
                }
            else if(gObjUserBean.role == 2){
                 self.labelProfileRole.text = "SPEAKER"
            }
            else{
                 self.labelProfileRole.text = "BOTH"
            }
        }
        else{
            
            if (gObjUserBean.school_id == gObjMakeMySchoolListBean.school_id)
            {
                self.labelProfileSchool.text = gObjUserBean.school_name
            }
            else{
                self.labelProfileSchool.text = gObjUserBean.school_name
            }
            self.labelProfileName.text = gObjMakeMySchoolListBean.name
            
            self.labelProfileGrades.text = gObjMakeMySchoolListBean.grades
            self.labelProfileBiography.text = gObjMakeMySchoolListBean.biography
            self.labelProfileJobTitle.text = gObjMakeMySchoolListBean.job_title
            self.labelProfileBusiness.text = gObjMakeMySchoolListBean.business
            
            self.labelProfileEmail.text = gObjMakeMySchoolListBean.email
            self.labelProfileRole.text = gObjMakeMySchoolListBean.role

        }
        
        
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.y + 300)
        //scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.x + 700)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
    }
    @IBAction func btnEditProfileClick(sender: AnyObject) {
        
        self.txtProfileGrades.hidden    = false
        self.txtProfileBiography.hidden = false
        self.txtProfileJobTItle.hidden  = false
        self.txtProfileBusiness.hidden  = false
        if (userProfileBean != nil){
            self.txtProfileId.text = String(userProfileBean.id)
            self.txtProfileGrades.text = userProfileBean.grades
            self.txtProfileBiography.text = userProfileBean.biography
            self.txtProfileJobTItle.text = userProfileBean.job_title
            self.txtProfileBusiness.text = userProfileBean.business
        
        }
        else{
             self.txtProfileId.text = String(gObjMakeMySchoolListBean.id)
            self.txtProfileGrades.text = gObjMakeMySchoolListBean.grades
            self.txtProfileBiography.text = gObjMakeMySchoolListBean.biography
            self.txtProfileJobTItle.text = gObjMakeMySchoolListBean.job_title
            self.txtProfileBusiness.text = gObjMakeMySchoolListBean.business
        }
        self.labelProfileGrades.hidden = true
        self.labelProfileBiography.hidden = true
        self.labelProfileJobTitle.hidden = true
        self.labelProfileBusiness.hidden = true
        
        self.btnEditProfile.hidden = true
        self.btnEditAccount.hidden = true
        
        
        self.btnSaveProfile.hidden = false
        self.btnFindMySchool.hidden = false
      

    }
    
    
    @IBAction func btnSaveProfileClick(sender: AnyObject) {
        
        self.txtProfileGrades.hidden    = true
        self.txtProfileBiography.hidden = true
        self.txtProfileJobTItle.hidden  = true
        self.txtProfileBusiness.hidden  = true
        
        self.labelProfileGrades.hidden = false
        self.labelProfileBiography.hidden = false
        self.labelProfileJobTitle.hidden = false
        self.labelProfileBusiness.hidden = false
        
        self.btnEditProfile.hidden = false
        self.btnEditAccount.hidden = false
        
        
        self.btnSaveProfile.hidden = true
        self.btnFindMySchool.hidden = true
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.EDIT_USER_PROFILE)
    }
    
    
    @IBAction func btnFIndMySchoolClick(sender: AnyObject) {
        
       
            navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItems = [menuButton,searchButton]
            searchBar.sizeToFit()
            searchBar.becomeFirstResponder()
            searchBar.showsCancelButton = true
            
            
            //navigationBar.items = [navigationItem]
            searchView.hidden = false
            schoolsRadioBtn.selected = true
            eventsRadioBtn.selected = false
            gBtnRadioValue = "schools"
        
        
    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
}
    
    @IBAction func btnAccountEditClick(sender: AnyObject) {
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.VIEW_ACCOUNT_EDIT)
    }
    
    
}


