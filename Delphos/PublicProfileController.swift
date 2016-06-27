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
   
   
    @IBOutlet var btnSaveProfile: UIButton!
    @IBOutlet var btnFindMySchool: UIButton!
    @IBOutlet var btnEditProfile: UIButton!
    @IBOutlet var btnEditAccount: UIButton!
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    var userProfileBean: UserBean!
    
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
        
         self.txtProfileGrades.hidden = true
         self.txtProfileBiography.hidden = true
         self.txtProfileJobTItle.hidden = true
         self.txtProfileBusiness.hidden = true
        
         self.btnSaveProfile.hidden = true
         self.btnFindMySchool.hidden = true
        
         self.btnEditProfile.hidden = false
         self.btnEditAccount.hidden = false
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
            else if(userProfileBean.role == 2){
                 self.labelProfileRole.text = "SPEAKER"
            }
            else{
                 self.labelProfileRole.text = "BOTH"
            }
        }
        else{
            
            if (gObjMakeMySchoolListBean.school_id == 2)
            {
                self.labelProfileSchool.text = "Delphos School"
            }
            else{
                self.labelProfileSchool.text = "Delphos School"
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
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.y + 500)
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
            
            gBtnRadioValue = "schools"
        
        
    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
}
    
    
    
}


