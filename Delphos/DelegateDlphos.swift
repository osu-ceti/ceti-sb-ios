//
//  DelegateDlphos.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

/**
 * Delegate class that delegates control to all Models.
 */
class DelegateDiphos: NSObject {
    
    var doPostAPIs: DAOPostAPIs
    var doGetAPIs: DAOGetAPIs
    var rootController : UINavigationController!
    
    override init() {
        doPostAPIs = DAOPostAPIs()
        doGetAPIs = DAOGetAPIs()
    }

    
    func delegateControl(objCurrentController: UIViewController, action enmAction: DelphosAction) {
       
        print("Delegate(delegateControl) - Action: \(enmAction)")
        
        switch(enmAction)
        {
        case .LOGIN:
            print("Login")
            login(objCurrentController)
            
        case .EVENT_ALL:
            print("Event All")
            showAllEvents(objCurrentController)

        case .REGISTER:
            print("Regsiter")
            register(objCurrentController)

        default:
            print("Error in delegate enum")
        


        }
    }
    
    func login(objCurrentContoller: UIViewController) -> Bool {
        var boolLogin = false;
        let loginController = objCurrentContoller as! ViewController
        
        let strUser = loginController.userTxt.text
        let strPassword = loginController.passwordTxt.text
        var objInputParamBean: LoginBean = LoginBean()
        var objInputParamCredsBean: CredentialsBean = CredentialsBean()
        objInputParamCredsBean.email = strUser
        objInputParamCredsBean.password = strPassword
        objInputParamBean.user = objInputParamCredsBean
        
        //DOA calls
        doPostAPIs.doLogin(objInputParamBean){ (loginResult: AnyObject, statusCode: Int) in
            
            if (statusCode == 200){
                print("Login Sucessfull")
                boolLogin = true;
                   dispatch_async(dispatch_get_main_queue(), {
                    
                let goToEventDisplay = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("eventDisplayID") as! EventDisplayController
                   objCurrentContoller.presentViewController(goToEventDisplay, animated: true, completion: nil)
                })
            }
            else {
                print("Login failure")
                boolLogin = false;
            }
        }
        return boolLogin
    }

    func showAllEvents(objCurrentContoller: UIViewController) {
         doGetAPIs.getAllEvents { (result: AnyObject,statusCode: Int) in
            if(statusCode != 0){
                print("Show event")
                //var objEventDisplayBean = result as! EventDisplayBean
                dispatch_async(dispatch_get_main_queue(), {

                    
                gObjEventDisplayBean = result as! EventDisplayBean
                    print("Show", gObjEventDisplayBean)
                    
                })
            }
        }
    }
    func register(objCurrentContoller: UIViewController) -> Bool {
        var boolRegister = false
        let registerController = objCurrentContoller as! RegisterController
        let strName = registerController.txtName.text
        let strEmail = registerController.txtEmail.text
        let strPassword = registerController.txtPassword.text
        let strRole = registerController.txtRole.text
        let strConformPassword = registerController.txtConformPassword.text
        var objInputParamBean: CredentialsBean = CredentialsBean()
        var objInputRegisterBean: LoginBean = LoginBean()
        objInputParamBean.name = strName
        objInputParamBean.email = strEmail
          objInputParamBean.password = strPassword
          objInputParamBean.role = strRole
       objInputParamBean.password_confirmation = strConformPassword
        objInputParamBean.school_id = "1"
        
        objInputRegisterBean.user = objInputParamBean
        objInputRegisterBean.commit = "Create my account"
        
        doPostAPIs.doRegister(objInputRegisterBean){ (loginResult: AnyObject, statusCode: Int) in
            if(statusCode == 200) {
                boolRegister = true
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let goToLoginController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("loginId") as! ViewController
                    objCurrentContoller.presentViewController(goToLoginController, animated: true, completion: nil)
                })
            }
            
        }
        return boolRegister
    }
    
}


