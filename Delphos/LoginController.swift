//
//  ViewController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginController: BaseController {
    
    @IBOutlet var userTxt: UITextField!
    
    @IBOutlet var passwordTxt: UITextField!
    
    @IBOutlet var switchRememberme: UISwitch!
    
    @IBOutlet var scrollView: UIScrollView!
    
    var isResetPassword:Bool = false
   
   
    var userNameData:String!
    
   
    var userPasswordData:String!
    
 
   
  

   //var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
   //var searchButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()

    @IBOutlet var requiredError: UILabel!
    
    @IBOutlet var btnResetPassword: UIButton!
   
    @IBOutlet var labelRememberMe: UILabel!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnRegister: UIButton!
    
    
    @IBOutlet var btnForgetPassword: UIButton!
    var backButton : UIBarButtonItem = UIBarButtonItem()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         rootViewController = self
         self.requiredError.isHidden = true
        
        // isResetPassword = false
        
        
        if (UserDefaults.standard.string(forKey: gStrUserStorageKey) != nil &&
            UserDefaults.standard.string(forKey: gStrUserStoragePassKey) != nil){
             //self.showOverlay(self.view)
        
             userNameData = UserDefaults.standard.string(forKey: gStrUserStorageKey)!
             userPasswordData = UserDefaults.standard.string(forKey: gStrUserStoragePassKey)!
       

            
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
             let testfacade = appDelegate.getObjFacade()
             testfacade.doTask(self,action: DelphosAction.login)
            }
        
     

        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
       
      
        
        
        
        self.view.backgroundColor = bgColor
        
        self.btnResetPassword.isHidden = true



        switchRememberme.transform = CGAffineTransform(scaleX: 0.50, y: 0.50);
       
        
        //Bottom border
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0, y: userTxt.frame.height - 1, width: userTxt.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        userTxt.borderStyle = UITextBorderStyle.none
        userTxt.layer.addSublayer(bottomLine)
        
        let textboxLine = CALayer()
        textboxLine.frame = CGRect(x: 0.0, y: passwordTxt.frame.height - 1, width: passwordTxt.frame.width, height: 1.0)
        textboxLine.backgroundColor = UIColor.black.cgColor
        passwordTxt.borderStyle = UITextBorderStyle.none
        passwordTxt.layer.addSublayer(textboxLine)
        
        rootViewController = self            
        
      

    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.passwordTxt.frame.origin.y + 500)
        scrollView.isScrollEnabled = true
        //view.addSubview(scrolview)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func touchEvent(_ sender: UITextField) {
        self.requiredError.isHidden = true
    }
    
    
    @IBAction func touchRequiredHidePassword(_ sender: AnyObject) {
         self.requiredError.isHidden = true
    }
    @IBAction func btnSignIn(_ sender: UIButton) {
        
        let trimmedName = userTxt.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let trimmedPassword = passwordTxt.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (trimmedName == ""){
            self.requiredError.isHidden = false
            self.requiredError.text = "Required Email"
           //  self.showAlert(objCurrentContoller, strMessage: "Invalid UserName and Password")
        }
        else if (trimmedName != "" )
        {
            var emailvalid = isValidEmail(trimmedName)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredError.isHidden = false
                self.requiredError.text =  "Required Vaild Email"
                
            }
        
        else if (trimmedPassword == "")
        {
            self.requiredError.isHidden = false
            self.requiredError.text = "Required Password"
        }
       
            
        else{
            userTxt.text = trimmedName
            passwordTxt.text = trimmedPassword
        //self.showOverlay(self.view)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.login)
        }
        }
    }

    @IBAction func btnForgetPasswordClick(_ sender: AnyObject) {
        
        isResetPassword = true
        
        if(isResetPassword){
           
            gObjLoginController = self.fetchNavController(gStrLoginControllerID)
            
            gObjBackTocontroller = gObjLoginController
            
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backToSomeController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
        }
        
        self.btnResetPassword.isHidden = false
        self.passwordTxt.isHidden = true
        self.switchRememberme.isHidden = true
        self.btnRegister.isHidden = true
        self.btnSignIn.isHidden = true
        self.labelRememberMe.isHidden = true
        self.btnForgetPassword.isHidden = true
    }
    func backToSomeController(_ sender: UIBarButtonItem){
       
        
        self.slideMenuController()?.changeMainViewController(gObjBackTocontroller, close: true)
        
    }
   
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluate(with: testStr))
        
        return emailTest.evaluate(with: testStr)
        
        
    }

    @IBAction func btnResetPasswordClick(_ sender: AnyObject) {
        
        
        let trimmedEmail = userTxt.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (trimmedEmail == ""){
            self.requiredError.isHidden = false
            self.requiredError.text = "Required Email"
            //  self.showAlert(objCurrentContoller, strMessage: "Invalid UserName and Password")
        }
        
        else if (trimmedEmail != "" )
        {
            var emailvalid = isValidEmail(trimmedEmail)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredError.isHidden = false
                self.requiredError.text =  "Required Vaild Email"
                
            }
        else{
        
                userTxt.text = trimmedEmail
                
            //self.showOverlay(self.view)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.reset_FORGET_PASSWORD)
        }
     }
    }

   
    @IBAction func btnRegister(_ sender: UIButton) {
        
        var registerController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterId") as! RegisterController
        
        let registerControllerNav = UINavigationController(rootViewController: registerController)
        
        self.slideMenuController()?.changeMainViewController(registerControllerNav, close: false)
        

        
        }
    
}

