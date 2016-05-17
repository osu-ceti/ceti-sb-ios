//
//  ViewController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {
    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var schoolbusiness: UILabel!
    
    @IBOutlet weak var switchRememberme: UISwitch!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var color = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        view.backgroundColor = color
        schoolbusiness.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        schoolbusiness.layer.shadowOpacity = 4
        schoolbusiness.layer.shadowRadius  = 2
        schoolbusiness.layer.shadowOffset = CGSizeMake(2, 2);
        
       
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnSignIn(sender: UIButton) {

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.LOGIN)
        
    }


    @IBAction func btnRegister(sender: UIButton) {
        
        let goToRegisterController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterId") as! RegisterController
        self.presentViewController(goToRegisterController, animated: true, completion: nil)
    }
}

