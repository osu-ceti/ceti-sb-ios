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
    
    @IBOutlet var btnEditProfile: UIButton!
    
    @IBOutlet var btnEditAccount: UIButton!
    @IBOutlet var btnSaveProfile: UIButton!
    @IBOutlet var btnFindMySchool: UIButton!
    
    @IBOutlet var btnPublicProfile: UIButton!
    
    @IBOutlet var btnProfileSchoolLink: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    var userProfileBean: UserBean!
    
    @IBOutlet var requiredField: UILabel!
    @IBOutlet var changeLabelName: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootViewController = self
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = false
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //let bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        self.requiredField.isHidden = true
        hideLabelAccountSetting.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelPublicProfile.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelName.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelGrades.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelSchool.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelJobTitle.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelBusiness.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelBio.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelRole.font = UIFont.boldSystemFont(ofSize: 15)
        hideLabelEmail.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.changeLabelName.isHidden = true
        self.txtProfileGrades.isHidden = true
        self.txtProfileBiography.isHidden = true
        self.txtProfileJobTItle.isHidden = true
        self.txtProfileBusiness.isHidden = true
        
        self.btnSaveProfile.isHidden = true
        self.btnFindMySchool.isHidden = true
        
        self.btnEditProfile.isHidden = false
        self.btnEditAccount.isHidden = false
        

        
        
        if (userProfileBean != nil){
            
         self.labelProfileName.text = userProfileBean.name
         btnProfileSchoolLink.setTitle(userProfileBean.school_name, for: UIControlState())
         
            
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
                
                self.btnProfileSchoolLink.isHidden = true
                
                 self.changeLabelName.isHidden = false
                self.labelProfileName.isHidden = true
                self.hideLabelName.isHidden = true
                
                self.hideLabelSchool.text = "Name"
                self.changeLabelName.text = userProfileBean.name
            }
            else{
                 self.labelProfileRole.text = "BOTH"
            }
        }
        else{
            
            if (gObjUserBean.school_id == gObjMakeMySchoolListBean.school_id)
            {
                btnProfileSchoolLink.setTitle(gObjUserBean.school_name, for: UIControlState())
            }
            else{
                btnProfileSchoolLink.setTitle(gObjUserBean.school_name, for: UIControlState())
            }
           // btnProfileSchoolLink.setTitle( userProfileBean.school_name, forState: .Normal)
            self.labelProfileName.text = gObjMakeMySchoolListBean.name
            
            self.labelProfileGrades.text = gObjMakeMySchoolListBean.grades
            self.labelProfileBiography.text = gObjMakeMySchoolListBean.biography
            self.labelProfileJobTitle.text = gObjMakeMySchoolListBean.job_title
            self.labelProfileBusiness.text = gObjMakeMySchoolListBean.business
            
            self.labelProfileEmail.text = gObjMakeMySchoolListBean.email
            self.labelProfileRole.text = gObjMakeMySchoolListBean.role

        }
        
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.btnEditAccount.frame.origin.y + 300)
        //scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.x + 700)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    @IBAction func btnEditProfileClick(_ sender: AnyObject) {
        
        self.txtProfileGrades.isHidden    = false
        self.txtProfileBiography.isHidden = false
        self.txtProfileJobTItle.isHidden  = false
        self.txtProfileBusiness.isHidden  = false
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
        self.labelProfileGrades.isHidden = true
        self.labelProfileBiography.isHidden = true
        self.labelProfileJobTitle.isHidden = true
        self.labelProfileBusiness.isHidden = true
        
        self.btnEditProfile.isHidden = true
        self.btnEditAccount.isHidden = true
        
        
        self.btnSaveProfile.isHidden = false
        self.btnFindMySchool.isHidden = false
      

    }
    
    
    @IBAction func btnSaveProfileClick(_ sender: AnyObject) {
        
        
        
        var trimmedGrades = txtProfileGrades.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        var trimmedBio = txtProfileBiography.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        var trimmedJobTitle = txtProfileJobTItle.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        var trimmedBusiness = txtProfileBusiness.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(trimmedGrades == ""){
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Grades"
            
        }else if(trimmedBio == ""){
                        self.requiredField.isHidden = false
                        self.requiredField.text = "Required Biography"

        
        }
        else if(trimmedJobTitle == ""){
                        self.requiredField.isHidden = false
                        self.requiredField.text = "Required Job TItle"
           
        }
        else if(trimmedBusiness == ""){
                        self.requiredField.isHidden = false
                        self.requiredField.text = "Required Business"
            
        }else{
            self.requiredField.isHidden = true
            txtProfileGrades.text = trimmedGrades
            txtProfileBiography.text = trimmedBio
            txtProfileJobTItle.text = trimmedJobTitle
            txtProfileBusiness.text = trimmedBusiness
          
            self.txtProfileGrades.isHidden    = true
            self.txtProfileBiography.isHidden = true
            self.txtProfileJobTItle.isHidden  = true
            self.txtProfileBusiness.isHidden  = true
            
            self.labelProfileGrades.isHidden = false
            self.labelProfileBiography.isHidden = false
            self.labelProfileJobTitle.isHidden = false
            self.labelProfileBusiness.isHidden = false
            
            self.btnEditProfile.isHidden = false
            self.btnEditAccount.isHidden = false
            
            
            self.btnSaveProfile.isHidden = true
            self.btnFindMySchool.isHidden = true
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.edit_USER_PROFILE)
       }
    }
    
    
     func btnFIndMySchoolClick(_ sender: AnyObject) {
        
            self.searchBar.isHidden = false
            navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItems = [menuButton,searchButton]
            searchBar.sizeToFit()
            searchBar.becomeFirstResponder()
            searchBar.showsCancelButton = true
            segmentSearchItems.selectedSegmentIndex = UISegmentedControlNoSegment
            segmentSearchItems.selectedSegmentIndex = 1
            //navigationBar.items = [navigationItem]
            searchView.isHidden = false
           
            gBtnRadioValue = "schools"
        
        
    }
   
    
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
}
    
    @IBAction func btnAccountEditClick(_ sender: AnyObject) {
    
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.view_ACCOUNT_EDIT)
    }
    
     func btnProfileSchoolClick(_ sender: AnyObject) {
        if(gObjUserBean.school_id != 1){
           
           // gSchoolId = userProfileBean.school_id
            
            gSchoolId =   gObjUserBean.school_id
            
            self.showOverlay(self.view)
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
    
}


