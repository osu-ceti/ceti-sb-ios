//
//  RegisterController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class RegisterController: UIViewController,UINavigationBarDelegate, UITextFieldDelegate, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var schoolbusiness: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConformPassword: UITextField!
    
    @IBOutlet weak var radioTeacher: SSRadioButton!
    @IBOutlet weak var radioSpeaker: SSRadioButton!
    @IBOutlet weak var radioBoth: SSRadioButton!
    let checkCharacter = NSCharacterSet.letterCharacterSet()
    var radioButtonController: SSRadioButtonsController?
    
    @IBOutlet weak var requiredField: UILabel!
    
    
    var arrRole = ["Speaker", "Teacher" ,"Both"]
    
    var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
   // var backButton = UIButton(frame: CGRectMake(0,40,40,0))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    self.requiredField.hidden = true
        // Create the navigation bar
        navigationBar = UINavigationBar(frame: CGRectMake(0, 17, self.view.frame.size.width, 44))
        navigationBar.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)
        navigationBar.delegate = self;
        navigationBar.layer.shadowOpacity = 4
        navigationBar.layer.shadowRadius  = 2
        navigationBar.layer.shadowOffset = CGSizeMake(2, 2);
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "School-Business"
       
        searchButtonItem = UIBarButtonItem(customView:searchBar)
        // Create left and right button for navigation item
        
       // searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "btnSearchClick:")
        
        let backimage = UIImage(contentsOfFile:"backarrow")
       searchButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: nil, action: "back:")
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = searchButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        

        
        radioButtonController = SSRadioButtonsController(buttons: radioTeacher, radioSpeaker,radioBoth)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        var color = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        view.backgroundColor = color
        
//        schoolbusiness.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
//        schoolbusiness.layer.shadowOpacity = 4
//        schoolbusiness.layer.shadowRadius  = 2
//        schoolbusiness.layer.shadowOffset = CGSizeMake(2, 2);
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, txtName.frame.height - 1, txtName.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
        txtName.borderStyle = UITextBorderStyle.None
        txtName.layer.addSublayer(bottomLine)
        var textboxLine = CALayer()
        textboxLine.frame = CGRectMake(0.0, txtEmail.frame.height - 1, txtEmail.frame.width, 1.0)
        textboxLine.backgroundColor = UIColor.blackColor().CGColor
        txtEmail.borderStyle = UITextBorderStyle.None
        txtEmail.layer.addSublayer(textboxLine)
        var PasswordLine = CALayer()
        PasswordLine.frame = CGRectMake(0.0, txtPassword.frame.height - 1, txtPassword.frame.width, 1.0)
        PasswordLine.backgroundColor = UIColor.blackColor().CGColor
        txtPassword.borderStyle = UITextBorderStyle.None
        txtPassword.layer.addSublayer(PasswordLine)
        var ConformPasswordLine = CALayer()
        ConformPasswordLine.frame = CGRectMake(0.0, txtConformPassword.frame.height - 1, txtConformPassword.frame.width, 1.0)
        ConformPasswordLine.backgroundColor = UIColor.blackColor().CGColor
        txtConformPassword.borderStyle = UITextBorderStyle.None
        txtConformPassword.layer.addSublayer(ConformPasswordLine)

    }
    func back(sender: UIBarButtonItem){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("loginId") as! ViewController
        self.presentViewController(nextViewController,animated:true,completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }
        
    func btnAdd(sender:UIButton) {
        print("clicked")
    }

    @IBAction func btnTeacher(sender: UIButton) {
        gBtnRegisterRadio = "Teacher"
        
    }
    
    @IBAction func btnSpeaker(sender: UIButton) {
        gBtnRegisterRadio = "Speaker"
    }
   
    @IBAction func btnBoth(sender: UIButton) {
        gBtnRegisterRadio = "Both"
    }
    
    @IBAction func touchRequiredHideName(sender: AnyObject) {
         self.requiredField.hidden = true
        
    }
    @IBAction func touchrequiredHideEmail(sender: AnyObject) {
        self.requiredField.hidden = true
    }
    @IBAction func touchRequiredHidePassword(sender: AnyObject) {
        self.requiredField.hidden = true
    }
    @IBAction func touchRequiredHideConPwd(sender: AnyObject) {
        self.requiredField.hidden = true
    }
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
       let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluateWithObject(testStr))
       
        return emailTest.evaluateWithObject(testStr)
       
        
    }
    @IBAction func btnRegister(sender: UIButton) {
    
        if(txtName.text == "" || txtName.text!.rangeOfCharacterFromSet(checkCharacter.invertedSet) != nil  ){
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
            print(emailvalid)
            if(emailvalid == false ){
                self.requiredField.hidden = false
                self.requiredField.text = "Required Vaild Email"
              
            }
            else{
            
            
        
        if (txtPassword.text! == "")
        {
            self.requiredField.hidden = false
            self.requiredField.text = "Required Password OR Password Must have 8 character"
        }
        else if (txtConformPassword.text == "")
        {
            self.requiredField.hidden = false
            self.requiredField.text = "Required ConfirmPassword"
        }
        
//        else if (gBtnRegisterRadio == "")
//        {
//            self.requiredField.hidden = false
//            self.requiredField.text = "Required Role"
//        }
        else {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.REGISTER)
        }
            }
        }
    }
   
}