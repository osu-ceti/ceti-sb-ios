//
//  ViewController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginController: UIViewController {
    
    @IBOutlet var userTxt: UITextField!
    
    @IBOutlet var passwordTxt: UITextField!
    
    @IBOutlet var switchRememberme: UISwitch!
    
    @IBOutlet var scrollView: UIScrollView!
    
     @IBOutlet var btnResetPassword: UIButton!
    
    @IBOutlet var labelRememberMe: UILabel!
    @IBOutlet var btnSignIn: UIButton!
     @IBOutlet var btnRegister: UIButton!
   
    var userNameData:String!
    
   
    var userPasswordData:String!
    
    @IBOutlet var btnForgetPassword: UIButton!
   
//   
   // var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
   // var searchButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()

    @IBOutlet var requiredError: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
         rootViewController = self
         self.requiredError.hidden = true
        
        
        if (NSUserDefaults.standardUserDefaults().stringForKey("userNameKey") != nil &&
            NSUserDefaults.standardUserDefaults().stringForKey("userPasswordKey") != nil){
        
             userNameData = NSUserDefaults.standardUserDefaults().stringForKey("userNameKey")!
             userPasswordData = NSUserDefaults.standardUserDefaults().stringForKey("userPasswordKey")!
       
             print("userNamedata====",userNameData)
             print("passwordData====",userPasswordData)
            
             let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
             let testfacade = appDelegate.getObjFacade()
             testfacade.doTask(self,action: DelphosAction.LOGIN)
            }
        
        // Create the navigation bar
        //navigationBar = UINavigationBar(frame: CGRectMake(0, 17, self.view.frame.size.width, 44))
//        navigationBar.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)
//        navigationBar.delegate = self;
//        navigationBar.layer.shadowOpacity = 4
//        navigationBar.layer.shadowRadius  = 2
//        navigationBar.layer.shadowOffset = CGSizeMake(2, 2);
//        // Create a navigation item with a title
//        let navigationItem = UINavigationItem()
        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
        // Create left and right button for navigation item
        
        //searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "btnSearchClick:")
        
        // Create two buttons for the navigation item
        //navigationItem.leftBarButtonItem = searchButton
        
        // Assign the navigation item to the navigation bar
        //navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
       // self.view.addSubview(navigationBar)

        // Do any additional setup after loading the view, typically from a nib.
        
        var color = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        view.backgroundColor = color

//        userTxt.text = "jith87@gmail.com"
//        passwordTxt.text = "ontojith"

        switchRememberme.transform = CGAffineTransformMakeScale(0.50, 0.50);
       
        
        //Bottom border
        
        var bottomLine = CALayer()
        
        bottomLine.frame = CGRectMake(0.0, userTxt.frame.height - 1, userTxt.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
        userTxt.borderStyle = UITextBorderStyle.None
        userTxt.layer.addSublayer(bottomLine)
        
        var textboxLine = CALayer()
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
        
        
        if (userTxt.text == ""){
            self.requiredError.hidden = false
            self.requiredError.text = "Required Username"
           //  self.showAlert(objCurrentContoller, strMessage: "Invalid UserName and Password")
        }
        else if (passwordTxt.text == "")
        {
            self.requiredError.hidden = false
            self.requiredError.text = "Required Password"
        }
            
        else{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.LOGIN)
        }
    }

   
  
   
   
    @IBAction func btnRegister(sender: UIButton) {
        
        var registerController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterId") as! RegisterController
        
        let registerControllerNav = UINavigationController(rootViewController: registerController)
        
        self.slideMenuController()?.changeMainViewController(registerControllerNav, close: false)
        
//            let goToRegisterController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterId") as! RegisterController
//            self.presentViewController(goToRegisterController, animated: true, completion: nil)
        
        }
    
}

