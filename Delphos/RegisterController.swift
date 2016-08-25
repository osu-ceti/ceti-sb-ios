//
//  RegisterController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
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


class RegisterController: NavController, UITextFieldDelegate {
    
    @IBOutlet weak var schoolbusiness: UILabel!
   
    
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
   
    @IBOutlet var txtConformPassword: UITextField!
    

    let checkCharacter = CharacterSet.letters
   
    
    @IBOutlet var requiredField: UILabel!
    @IBOutlet var btnRegister: UIButton!
   
    
    @IBOutlet var scrollView: UIScrollView!
    
    var arrRole = ["Speaker", "Teacher" ,"Both"]
    
    
    @IBOutlet var segmentUserRole: UISegmentedControl!
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Adding SideMenu
        menus = gRegisterMenu
        rightViewController.isRegister = true
        rightViewController.tableView.reloadData()
        
        //Adding Navbar
        self.isBackEnabled = false
        self.isSearchEnabled = false
        
           backButtonNav = "loginId"
        setNavBar(self.view.frame.size.width)
        //searchBar.delegate = self
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "loginId") as! LoginController
       self.backToController = UINavigationController(rootViewController: loginController)
        self.shouldClose = true
        //backToView = "Back"
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.btnRegister.frame.origin.y + 700)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewController = self
        // Do any additional setup after loading the view, typically from a nib.
        gBtnRegisterRadio = ""
        self.requiredField.isHidden = true

        
        self.segmentUserRole.selectedSegmentIndex = UISegmentedControlNoSegment
        
      
        
        
        
        let color = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        view.backgroundColor = color
        
  
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtName.frame.height - 1, width: txtName.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        txtName.borderStyle = UITextBorderStyle.none
        txtName.layer.addSublayer(bottomLine)
        
        let textboxLine = CALayer()
        textboxLine.frame = CGRect(x: 0.0, y: txtEmail.frame.height - 1, width: txtEmail.frame.width, height: 1.0)
        textboxLine.backgroundColor = UIColor.black.cgColor
        txtEmail.borderStyle = UITextBorderStyle.none
        txtEmail.layer.addSublayer(textboxLine)
       
        let PasswordLine = CALayer()
        PasswordLine.frame = CGRect(x: 0.0, y: txtPassword.frame.height - 1, width: txtPassword.frame.width, height: 1.0)
        PasswordLine.backgroundColor = UIColor.black.cgColor
        txtPassword.borderStyle = UITextBorderStyle.none
        txtPassword.layer.addSublayer(PasswordLine)
       
        let ConformPasswordLine = CALayer()
        ConformPasswordLine.frame = CGRect(x: 0.0, y: txtConformPassword.frame.height - 1, width: txtConformPassword.frame.width, height: 1.0)
        ConformPasswordLine.backgroundColor = UIColor.black.cgColor
        txtConformPassword.borderStyle = UITextBorderStyle.none
        txtConformPassword.layer.addSublayer(ConformPasswordLine)

    }


    
    @IBAction func touchRequiredHideName(_ sender: AnyObject) {
         self.requiredField.isHidden = true
        
    }
    @IBAction func touchrequiredHideEmail(_ sender: AnyObject) {
        self.requiredField.isHidden = true
    }
    @IBAction func touchRequiredHidePassword(_ sender: AnyObject) {
        self.requiredField.isHidden = true
    }
    @IBAction func touchRequiredHideConPwd(_ sender: AnyObject) {
        self.requiredField.isHidden = true
    }
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
       let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluate(with: testStr))
       
        return emailTest.evaluate(with: testStr)
       
        
    }

    @IBAction func touchUserRole(_ sender: AnyObject) {
        
        if(segmentUserRole.selectedSegmentIndex == 0){
            gBtnRegisterRadio = "Teacher"
        }
        else if(segmentUserRole.selectedSegmentIndex == 1 ){
            gBtnRegisterRadio = "Speaker"
        }
        else if(segmentUserRole.selectedSegmentIndex == 2){
            gBtnRegisterRadio = "Both"
        }

    }

    @IBAction func btnRegister(_ sender: UIButton) {
        
       
        

        
        var trimmedName = txtName.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines
        )
    
        if(trimmedName == ""){
            self.requiredField.isHidden = false
           self.requiredField.text = "Required Name"
            
        }
        else if (txtEmail.text == "" ){
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Email"
        
        }
        else if (txtEmail.text != "" )
        {
            var emailvalid = isValidEmail(txtEmail.text!)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredField.isHidden = false
                self.requiredField.text = "Required Vaild Email"
              
            }
            else{
            
            
        
        if (txtPassword.text! == "")
        {
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Password "
        }
                
        else if (txtPassword.text?.characters.count <= 7)
        {
            self.requiredField.isHidden = false
            self.requiredField.text = "Password Must have 8 character"
        }
        else if (txtConformPassword.text == "")
        {
            self.requiredField.isHidden = false
            self.requiredField.text = "Required ConfirmPassword"
        }
        else if (txtConformPassword.text != txtPassword.text!)
        {
            self.requiredField.isHidden = false
            self.requiredField.text = "ConfirmPassword does not match"
        }
        else if (gBtnRegisterRadio == "")
        {
            self.requiredField.isHidden = false
            self.requiredField.text = "Required Role"
        }
        else {
            
            txtName.text = trimmedName
            showOverlay(self.view)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.register)
        }
            }
        }
    }
   
   
  
}
