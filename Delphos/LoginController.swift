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
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
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
         self.requiredError.hidden = true
        
        // isResetPassword = false
        
        
        if (NSUserDefaults.standardUserDefaults().stringForKey(gStrUserStorageKey) != nil &&
            NSUserDefaults.standardUserDefaults().stringForKey(gStrUserStoragePassKey) != nil){
             //self.showOverlay(self.view)
        
             userNameData = NSUserDefaults.standardUserDefaults().stringForKey(gStrUserStorageKey)!
             userPasswordData = NSUserDefaults.standardUserDefaults().stringForKey(gStrUserStoragePassKey)!
       

            
             let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
             let testfacade = appDelegate.getObjFacade()
             testfacade.doTask(self,action: DelphosAction.LOGIN)
            }
        
     

        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
       
      
        
        
        let color = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        view.backgroundColor = color
        
        self.btnResetPassword.hidden = true



        switchRememberme.transform = CGAffineTransformMakeScale(0.50, 0.50);
       
        
        //Bottom border
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRectMake(0.0, userTxt.frame.height - 1, userTxt.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
        userTxt.borderStyle = UITextBorderStyle.None
        userTxt.layer.addSublayer(bottomLine)
        
        let textboxLine = CALayer()
        textboxLine.frame = CGRectMake(0.0, passwordTxt.frame.height - 1, passwordTxt.frame.width, 1.0)
        textboxLine.backgroundColor = UIColor.blackColor().CGColor
        passwordTxt.borderStyle = UITextBorderStyle.None
        passwordTxt.layer.addSublayer(textboxLine)
        
        rootViewController = self            
        
      

    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.passwordTxt.frame.origin.y + 500)
        scrollView.scrollEnabled = true
        //view.addSubview(scrolview)
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func touchEvent(sender: UITextField) {
        self.requiredError.hidden = true
    }
    
    
    @IBAction func touchRequiredHidePassword(sender: AnyObject) {
         self.requiredError.hidden = true
    }
    @IBAction func btnSignIn(sender: UIButton) {
        
        let trimmedName = userTxt.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let trimmedPassword = passwordTxt.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if (trimmedName == ""){
            self.requiredError.hidden = false
            self.requiredError.text = "Required Email"
           //  self.showAlert(objCurrentContoller, strMessage: "Invalid UserName and Password")
        }
        else if (trimmedName != "" )
        {
            var emailvalid = isValidEmail(trimmedName)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredError.hidden = false
                self.requiredError.text =  "Required Vaild Email"
                
            }
        
        else if (trimmedPassword == "")
        {
            self.requiredError.hidden = false
            self.requiredError.text = "Required Password"
        }
       
            
        else{
            userTxt.text = trimmedName
            passwordTxt.text = trimmedPassword
        //self.showOverlay(self.view)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.LOGIN)
        }
        }
    }

    @IBAction func btnForgetPasswordClick(sender: AnyObject) {
        
        isResetPassword = true
        
        if(isResetPassword){
           
            gObjLoginController = self.fetchNavController(gStrLoginControllerID)
            
            gObjBackTocontroller = gObjLoginController
            
            backButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.backToSomeController(_:)))
            
            navigationItem.leftBarButtonItem = backButton
        }
        
        self.btnResetPassword.hidden = false
        self.passwordTxt.hidden = true
        self.switchRememberme.hidden = true
        self.btnRegister.hidden = true
        self.btnSignIn.hidden = true
        self.labelRememberMe.hidden = true
        self.btnForgetPassword.hidden = true
    }
    func backToSomeController(sender: UIBarButtonItem){
       
        
        self.slideMenuController()?.changeMainViewController(gObjBackTocontroller, close: true)
        
    }
   
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluateWithObject(testStr))
        
        return emailTest.evaluateWithObject(testStr)
        
        
    }

    @IBAction func btnResetPasswordClick(sender: AnyObject) {
        
        
        let trimmedEmail = userTxt.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (trimmedEmail == ""){
            self.requiredError.hidden = false
            self.requiredError.text = "Required Email"
            //  self.showAlert(objCurrentContoller, strMessage: "Invalid UserName and Password")
        }
        
        else if (trimmedEmail != "" )
        {
            var emailvalid = isValidEmail(trimmedEmail)
            //print(emailvalid)
            if(emailvalid == false ){
                self.requiredError.hidden = false
                self.requiredError.text =  "Required Vaild Email"
                
            }
        else{
        
                userTxt.text = trimmedEmail
                
            //self.showOverlay(self.view)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.RESET_FORGET_PASSWORD)
        }
     }
    }

   
    @IBAction func btnRegister(sender: UIButton) {
        
        var registerController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterId") as! RegisterController
        
        let registerControllerNav = UINavigationController(rootViewController: registerController)
        
        self.slideMenuController()?.changeMainViewController(registerControllerNav, close: false)
        

        
        }
    
}

