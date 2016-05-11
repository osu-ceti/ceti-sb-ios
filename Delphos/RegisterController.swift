//
//  RegisterController.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
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