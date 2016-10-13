//
//  AccountEditController.swift
//  Delphos
//
//  Created by Babu on 7/18/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class AccountEditController: NavController {
    
    
    
    
    
    @IBOutlet var labelAccountName: UILabel!
    
    @IBOutlet var labelAccountEmail: UILabel!
    
    
    @IBOutlet var labelName: UILabel!
   
    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var labelChangePassword: UILabel!
    @IBOutlet var labelEnterNewPassword: UILabel!
    
    
    @IBOutlet var requiredField: UILabel!
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    
    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtCurrentPassword: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    
    @IBOutlet var accountSegmentedRole: UISegmentedControl!
    
    var accountEditId:Int!
    var txtRole:String!
    
    @IBOutlet var btnSaveAccount: UIButton!
    
     var userAccountEditBean: UserBean!
    
        
   
    
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
        
        self.view.backgroundColor = bgColor
        
        
        
        
        self.requiredField.isHidden = true
        
        self.BottomLine(txtName)
        self.BottomLine(txtEmail)
        self.BottomLine(txtNewPassword)
        self.BottomLine(txtConfirmPassword)
        self.BottomLine(txtCurrentPassword)



        
        
//        var bottomLine = CALayer()
//        bottomLine.frame = CGRectMake(0.0, txtName.frame.height - 1, txtName.frame.width, 1.0)
//        bottomLine.backgroundColor = UIColor.blackColor().CGColor
//        txtName.borderStyle = UITextBorderStyle.None
//        txtName.layer.addSublayer(bottomLine)
        
//        var txtEmailLine = CALayer()
//        txtEmailLine.frame = CGRectMake(0.0, txtEmail.frame.height - 1, txtEmail.frame.width, 1.0)
//        txtEmailLine.backgroundColor = UIColor.blackColor().CGColor
//        txtEmail.borderStyle = UITextBorderStyle.None
//        txtEmail.layer.addSublayer(txtEmailLine)
//        
//        var txtNewPasswordLine = CALayer()
//        txtNewPasswordLine.frame = CGRectMake(0.0, txtNewPassword.frame.height - 1, txtNewPassword.frame.width, 1.0)
//        txtNewPasswordLine.backgroundColor = UIColor.blackColor().CGColor
//        txtNewPassword.borderStyle = UITextBorderStyle.None
//        txtNewPassword.layer.addSublayer(txtNewPasswordLine)
//       
//        var txtConfirmPasswordLine = CALayer()
//        txtConfirmPasswordLine.frame = CGRectMake(0.0, txtConfirmPassword.frame.height - 1, txtConfirmPassword.frame.width, 1.0)
//        txtConfirmPasswordLine.backgroundColor = UIColor.blackColor().CGColor
//        txtConfirmPassword.borderStyle = UITextBorderStyle.None
//        txtConfirmPassword.layer.addSublayer(txtConfirmPasswordLine)
//       
//        
//        var txtCurrentPasswordLine = CALayer()
//        txtCurrentPasswordLine.frame = CGRectMake(0.0, txtCurrentPassword.frame.height - 1, txtCurrentPassword.frame.width, 1.0)
//        txtCurrentPasswordLine.backgroundColor = UIColor.blackColor().CGColor
//        txtCurrentPassword.borderStyle = UITextBorderStyle.None
//        txtCurrentPassword.layer.addSublayer(txtCurrentPasswordLine)

//        txtName.text = userAccountEditBean.name
//        txtEmail.text! = userAccountEditBean.email
//        accountEditId = userAccountEditBean.id
//       
//        if(userAccountEditBean.role == 1)
//        {
//            
//            txtRole = "Teacher"
//            accountSegmentedRole.selectedSegmentIndex = 0
//            
//        }
//        else if(userAccountEditBean.role == 2){
//           
//           
//            txtRole = "Speaker"
//            accountSegmentedRole.selectedSegmentIndex = 1
//
//        }
//        
//        else if(userAccountEditBean.role == 3)
//        {
//           
//            txtRole =  "Both"
//            accountSegmentedRole.selectedSegmentIndex = 2
//
//            
//           
//           
//        }
        
        
        if(userAccountEditBean != nil ){
            if(txtName != nil && userAccountEditBean.name != nil){
                txtName.text = userAccountEditBean.name
            }
            
            if(txtEmail != nil && userAccountEditBean.email != nil){
                txtEmail.text! = userAccountEditBean.email
            }
            accountEditId = userAccountEditBean.id
            if(userAccountEditBean.role != nil){
                if(userAccountEditBean.role == 1)
                {
                    
                    txtRole = "Teacher"
                    accountSegmentedRole.selectedSegmentIndex = 0
                    
                }
                else if(userAccountEditBean.role == 2){
                    
                    
                    txtRole = "Speaker"
                    accountSegmentedRole.selectedSegmentIndex = 1
                    
                }
                    
                else if(userAccountEditBean.role == 3)
                {
                    
                    txtRole =  "Both"
                    accountSegmentedRole.selectedSegmentIndex = 2
                    
                }
            }
        }
        
        
    }
//    override func hideOverlayView() {
//        activityIndicator.stopAnimating()
//        overlayView.removeFromSuperview()
//    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.btnSaveAccount.frame.origin.y + 300)
        //scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.x + 700)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    func BottomLine(_ textField:UITextField){
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        textField.borderStyle = UITextBorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
   
    
    @IBAction func accountUserRoleTouch(_ sender: AnyObject) {
        
        if(accountSegmentedRole.selectedSegmentIndex == 0){
            txtRole = "Teacher"
        }
        else if(accountSegmentedRole.selectedSegmentIndex == 1 ){
            txtRole = "Speaker"
        }
        else if(accountSegmentedRole.selectedSegmentIndex == 2){
            txtRole = "Both"
        }
        
        
        
    }
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluate(with: testStr))
        
        return emailTest.evaluate(with: testStr)
        
        
    }
    @IBAction func txtnametouchdown(_ sender: AnyObject) {
        self.requiredField.isHidden = true
    }
    @IBAction func txtNameTouch(_ sender: AnyObject) {
        
        
        self.requiredField.isHidden = true
    }
    @IBAction func txtEmailTouch(_ sender: AnyObject) {
        self.requiredField.isHidden = true
    }
    
    
    @IBAction func txtNewPasswordTouch(_ sender: AnyObject) {
        self.requiredField.isHidden = true
    }
    
    @IBAction func txtConfirmPasswordTouch(_ sender: AnyObject) {
        
        self.requiredField.isHidden = true
    }
    
    @IBAction func txtCurrentPasswordTouch(_ sender: AnyObject) {
        self.requiredField.isHidden = true
    }
    
   
    
    @IBAction func btnSaveAccountClick(_ sender: AnyObject) {
        let curPassword = txtCurrentPassword.text
        
        let trimmedText = txtName.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        let trimmedEmail = txtEmail.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(trimmedText == DelphosStrings.EMPTY_STRING){
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Name"
            
        }
        else if (trimmedEmail == DelphosStrings.EMPTY_STRING ){
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Email"
            
        }
        else if (trimmedEmail != DelphosStrings.EMPTY_STRING )
        {
            var emailvalid = isValidEmail(trimmedEmail)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredField.isHidden = false
                self.requiredField.text = "Required Vaild Email"
                
            }
            else{
//                if (txtNewPassword.text! == DelphosStrings.EMPTY_STRING)
//                {
//                    self.requiredField.hidden = false
//                    self.requiredField.text = "Required Password "
//                }
                
                if ((txtNewPassword.text! != DelphosStrings.EMPTY_STRING) && (txtNewPassword.text?.characters.count <= 7))
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "Password Must have 8 character"
                }
//                else if (txtConfirmPassword.text == DelphosStrings.EMPTY_STRING)
//                {
//                    self.requiredField.hidden = false
//                    self.requiredField.text = "Required ConfirmPassword"
//                }
                else if ((txtConfirmPassword.text != DelphosStrings.EMPTY_STRING) && (txtConfirmPassword.text != txtNewPassword.text!))
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "ConfirmPassword does not match"
                }
                else if (txtCurrentPassword.text == DelphosStrings.EMPTY_STRING)
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "Required Current Password"
                }
                else if (curPassword != gPasswordCheck)
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "Current password is not match"
                }
//                else if (txtRole == DelphosStrings.EMPTY_STRING)
//                {
//                    self.requiredField.hidden = false
//                    self.requiredField.text = "Required Role"
//                }
                else{
                    txtName.text = trimmedText
                    txtEmail.text = trimmedEmail
                    showOverlay(self.view)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.edit_PROFILE_ACCOUNT)
                
                
                }
            
            }
        
       

        
        }
    }
}
