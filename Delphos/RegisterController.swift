//
//  RegisterController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var schoolbusiness: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConformPassword: UITextField!
    
    @IBOutlet weak var txtRole: UITextField!
    @IBOutlet weak var pickerRole: UIPickerView!
     
    
    var arrRole = ["Speaker", "Teacher" ,"Both"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerRole.hidden = true
        txtRole.text = arrRole[0]
        txtRole.inputView = UIView()
        
        txtRole.delegate = self
        pickerRole.delegate = self
        pickerRole.dataSource = self
       // txtRole.inputView = pickerRole
        
        
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

    @IBAction func btnRegister(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.REGISTER)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrRole.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrRole[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       
            txtRole.text = arrRole[row]
        
            pickerRole.hidden = true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (textField == txtRole) {
            pickerRole.hidden = false
            self.pickerRole.layer.zPosition = 1
        }
        textField.resignFirstResponder()
       return false
    }

}