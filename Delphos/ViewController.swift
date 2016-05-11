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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

