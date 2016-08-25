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
        
        let bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        
        
        
        self.requiredField.isHidden = true
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtName.frame.height - 1, width: txtName.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        txtName.borderStyle = UITextBorderStyle.none
        txtName.layer.addSublayer(bottomLine)
        
        let txtEmailLine = CALayer()
        txtEmailLine.frame = CGRect(x: 0.0, y: txtEmail.frame.height - 1, width: txtEmail.frame.width, height: 1.0)
        txtEmailLine.backgroundColor = UIColor.black.cgColor
        txtEmail.borderStyle = UITextBorderStyle.none
        txtEmail.layer.addSublayer(txtEmailLine)
        
        let txtNewPasswordLine = CALayer()
        txtNewPasswordLine.frame = CGRect(x: 0.0, y: txtNewPassword.frame.height - 1, width: txtNewPassword.frame.width, height: 1.0)
        txtNewPasswordLine.backgroundColor = UIColor.black.cgColor
        txtNewPassword.borderStyle = UITextBorderStyle.none
        txtNewPassword.layer.addSublayer(txtNewPasswordLine)
       
        let txtConfirmPasswordLine = CALayer()
        txtConfirmPasswordLine.frame = CGRect(x: 0.0, y: txtConfirmPassword.frame.height - 1, width: txtConfirmPassword.frame.width, height: 1.0)
        txtConfirmPasswordLine.backgroundColor = UIColor.black.cgColor
        txtConfirmPassword.borderStyle = UITextBorderStyle.none
        txtConfirmPassword.layer.addSublayer(txtConfirmPasswordLine)
       
        
        let txtCurrentPasswordLine = CALayer()
        txtCurrentPasswordLine.frame = CGRect(x: 0.0, y: txtCurrentPassword.frame.height - 1, width: txtCurrentPassword.frame.width, height: 1.0)
        txtCurrentPasswordLine.backgroundColor = UIColor.black.cgColor
        txtCurrentPassword.borderStyle = UITextBorderStyle.none
        txtCurrentPassword.layer.addSublayer(txtCurrentPasswordLine)

        txtName.text = userAccountEditBean.name
        txtEmail.text! = userAccountEditBean.email
        accountEditId = userAccountEditBean.id
       
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
        
        if(trimmedText == ""){
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Name"
            
        }
        else if (trimmedEmail == "" ){
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Email"
            
        }
        else if (trimmedEmail != "" )
        {
            var emailvalid = isValidEmail(trimmedEmail)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredField.isHidden = false
                self.requiredField.text = "Required Vaild Email"
                
            }
            else{
//                if (txtNewPassword.text! == "")
//                {
//                    self.requiredField.hidden = false
//                    self.requiredField.text = "Required Password "
//                }
                
                if ((txtNewPassword.text! != "") && (txtNewPassword.text?.characters.count <= 7))
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "Password Must have 8 character"
                }
//                else if (txtConfirmPassword.text == "")
//                {
//                    self.requiredField.hidden = false
//                    self.requiredField.text = "Required ConfirmPassword"
//                }
                else if ((txtConfirmPassword.text != "") && (txtConfirmPassword.text != txtNewPassword.text!))
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "ConfirmPassword does not match"
                }
                else if (txtCurrentPassword.text == "")
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "Required Current Password"
                }
                else if (curPassword != gPasswordCheck)
                {
                    self.requiredField.isHidden = false
                    self.requiredField.text = "Current password is not match"
                }
//                else if (txtRole == "")
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
