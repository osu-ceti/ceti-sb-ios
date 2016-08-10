//
//  AccountEditController.swift
//  Delphos
//
//  Created by Babu on 7/18/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

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
    
    @IBOutlet var radioTeacher: SSRadioButton!
    @IBOutlet var radioBoth: SSRadioButton!
    @IBOutlet var radioSpeaker: SSRadioButton!
    
    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtCurrentPassword: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    
    
    var accountEditId:Int!
    var txtRole:String!
    
    @IBOutlet var btnSaveAccount: UIButton!
    
     var userAccountEditBean: UserBean!
    
    var radioButtonControllerLocal: SSRadioButtonsController?
    
   
    
    override func viewWillAppear(animated: Bool) {
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
        
        var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        view.backgroundColor = bgColor
        
        
        radioButtonControllerLocal = SSRadioButtonsController(buttons: radioTeacher,radioSpeaker,radioBoth)
        radioButtonControllerLocal!.delegate = self
        radioButtonControllerLocal!.shouldLetDeSelect = true
        
        self.requiredField.hidden = true
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, txtName.frame.height - 1, txtName.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
        txtName.borderStyle = UITextBorderStyle.None
        txtName.layer.addSublayer(bottomLine)
        
        var txtEmailLine = CALayer()
        txtEmailLine.frame = CGRectMake(0.0, txtEmail.frame.height - 1, txtEmail.frame.width, 1.0)
        txtEmailLine.backgroundColor = UIColor.blackColor().CGColor
        txtEmail.borderStyle = UITextBorderStyle.None
        txtEmail.layer.addSublayer(txtEmailLine)
        
        var txtNewPasswordLine = CALayer()
        txtNewPasswordLine.frame = CGRectMake(0.0, txtNewPassword.frame.height - 1, txtNewPassword.frame.width, 1.0)
        txtNewPasswordLine.backgroundColor = UIColor.blackColor().CGColor
        txtNewPassword.borderStyle = UITextBorderStyle.None
        txtNewPassword.layer.addSublayer(txtNewPasswordLine)
       
        var txtConfirmPasswordLine = CALayer()
        txtConfirmPasswordLine.frame = CGRectMake(0.0, txtConfirmPassword.frame.height - 1, txtConfirmPassword.frame.width, 1.0)
        txtConfirmPasswordLine.backgroundColor = UIColor.blackColor().CGColor
        txtConfirmPassword.borderStyle = UITextBorderStyle.None
        txtConfirmPassword.layer.addSublayer(txtConfirmPasswordLine)
       
        
        var txtCurrentPasswordLine = CALayer()
        txtCurrentPasswordLine.frame = CGRectMake(0.0, txtCurrentPassword.frame.height - 1, txtCurrentPassword.frame.width, 1.0)
        txtCurrentPasswordLine.backgroundColor = UIColor.blackColor().CGColor
        txtCurrentPassword.borderStyle = UITextBorderStyle.None
        txtCurrentPassword.layer.addSublayer(txtCurrentPasswordLine)

        txtName.text = userAccountEditBean.name
        txtEmail.text! = userAccountEditBean.email
        accountEditId = userAccountEditBean.id
       
        if(userAccountEditBean.role == 1)
        {
            radioTeacher.selected = true
            txtRole = "Teacher"
            
        }
        else if(userAccountEditBean.role == 2){
           
            radioSpeaker.selected = true
            txtRole = "Speaker"
        }
        
        else if(userAccountEditBean.role == 3)
        {
            radioBoth.selected = true
            txtRole =  "Both"
            
           
           
        }
        
        
    }
    override func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnSaveAccount.frame.origin.y + 300)
        //scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.btnEditAccount.frame.origin.x + 700)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
    }
    
    @IBAction func btnTeacher(sender: AnyObject) {
         txtRole = "Teacher"
    }
    
    @IBAction func btnSpeaker(sender: AnyObject) {
        txtRole = "Speaker"

    }
    
    @IBAction func btnBoth(sender: AnyObject) {
         txtRole =  "Both"
    }
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluateWithObject(testStr))
        
        return emailTest.evaluateWithObject(testStr)
        
        
    }
    @IBAction func txtnametouchdown(sender: AnyObject) {
        self.requiredField.hidden = true
    }
    @IBAction func txtNameTouch(sender: AnyObject) {
        
        
        self.requiredField.hidden = true
    }
    @IBAction func txtEmailTouch(sender: AnyObject) {
        self.requiredField.hidden = true
    }
    
    
    @IBAction func txtNewPasswordTouch(sender: AnyObject) {
        self.requiredField.hidden = true
    }
    
    @IBAction func txtConfirmPasswordTouch(sender: AnyObject) {
        
        self.requiredField.hidden = true
    }
    
    @IBAction func txtCurrentPasswordTouch(sender: AnyObject) {
        self.requiredField.hidden = true
    }
    
    @IBAction func btnSaveAccountClick(sender: AnyObject) {
        var curPassword = txtCurrentPassword.text
        
        if(txtName.text == ""){
            self.requiredField.hidden = false
            self.requiredField.text = "Required Name"
            
        }
        else if (txtEmail.text == "" ){
            self.requiredField.hidden = false
            self.requiredField.text = "Required Email"
            
        }
        else if (txtEmail.text != "" )
        {
            var emailvalid = isValidEmail(txtEmail.text!)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredField.hidden = false
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
                    self.requiredField.hidden = false
                    self.requiredField.text = "Password Must have 8 character"
                }
//                else if (txtConfirmPassword.text == "")
//                {
//                    self.requiredField.hidden = false
//                    self.requiredField.text = "Required ConfirmPassword"
//                }
                else if ((txtConfirmPassword.text != "") && (txtConfirmPassword.text != txtNewPassword.text!))
                {
                    self.requiredField.hidden = false
                    self.requiredField.text = "ConfirmPassword does not match"
                }
                else if (txtCurrentPassword.text == "")
                {
                    self.requiredField.hidden = false
                    self.requiredField.text = "Required Current Password"
                }
                else if (curPassword != gPasswordCheck)
                {
                    self.requiredField.hidden = false
                    self.requiredField.text = "Current password is not match"
                }
//                else if (txtRole == "")
//                {
//                    self.requiredField.hidden = false
//                    self.requiredField.text = "Required Role"
//                }
                else{
                    showOverlay(self.view)
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.EDIT_PROFILE_ACCOUNT)
                
                
                }
            
            }
        
       

        
        }
    }
}
