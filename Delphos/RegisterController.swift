//
//  RegisterController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var schoolbusiness: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConformPassword: UITextField!
    
    @IBOutlet weak var radioTeacher: SSRadioButton!
    @IBOutlet weak var radioSpeaker: SSRadioButton!
    @IBOutlet weak var radioBoth: SSRadioButton!
    
    var radioButtonController: SSRadioButtonsController?
    
    var arrRole = ["Speaker", "Teacher" ,"Both"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        radioButtonController = SSRadioButtonsController(buttons: radioTeacher, radioSpeaker,radioBoth)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        var color = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        view.backgroundColor = color
        
        schoolbusiness.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        schoolbusiness.layer.shadowOpacity = 4
        schoolbusiness.layer.shadowRadius  = 2
        schoolbusiness.layer.shadowOffset = CGSizeMake(2, 2);
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
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
    @IBAction func btnRegister(sender: UIButton) {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.REGISTER)
    }
   
}