//
//  UserDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit


class UserDelegate:BaseDelegate{
    
    func login(objCurrentContoller: UIViewController) -> Bool {
        var boolLogin = false;
        let loginController = objCurrentContoller as! LoginController
        
        let strUser = loginController.userTxt.text
        let strPassword = loginController.passwordTxt.text
        var objInputParamBean: LoginBean = LoginBean()
        var objInputParamCredsBean: CredentialsBean = CredentialsBean()
        objInputParamCredsBean.email = strUser
        objInputParamCredsBean.password = strPassword
        objInputParamBean.user = objInputParamCredsBean
        //DOA calls
        doPostAPIs.doLogin(objInputParamBean){ (loginResult: AnyObject, statusCode: Int) in
            
            if (statusCode == SUCCESS){
                print("Login Sucessfull")
                gObjUserBean = loginResult as! UserBean
                
                
                boolLogin = true;
                dispatch_async(dispatch_get_main_queue(), {
                    
                    //                var homeController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("HomeID") as! HomeController
                    //
                    //                    let homeControllerNav = UINavigationController(rootViewController: homeController)
                    
                    if(gObjHomeController == nil){
                        gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    }
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                    
                    
                    gObjUsers = loginResult as! UserBean
                    //                   objCurrentContoller.presentViewController(goToEventDisplay, animated: true, completion: nil)
                })
                
            }
            else if statusCode > SUCCESS{
                print("Login failure")
                boolLogin = false;
                self.showAlert(objCurrentContoller, strMessage:"Could not connect to the server." )
            }
            else {
                print("Login failure")
                boolLogin = false;
                self.showAlert(objCurrentContoller, strMessage: "Invalid UserName and Password")
            }
            
        }
        return boolLogin
    }
    
    
    
    
    func register(objCurrentContoller: UIViewController) -> Bool {
        var boolRegister = false
        let registerController = objCurrentContoller as! RegisterController
        let strName = registerController.txtName.text
        let strEmail = registerController.txtEmail.text
        let strPassword = registerController.txtPassword.text
        let strRole = gBtnRegisterRadio
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
            if(statusCode == SUCCESS) {
                boolRegister = true
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // self.showAlert(objCurrentContoller, strMessage: "Registration Success")
                    //                    let goToLoginController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("loginId") as! LoginController
                    //                    objCurrentContoller.presentViewController(goToLoginController, animated: true, completion: nil)
                    if(gObjLoginController == nil){
                        gObjLoginController = self.self.fetchNavController(gStrLoginControllerID)
                    }
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: false)
                })
            }
            else if(statusCode > SUCCESS) {
                self.showAlert(objCurrentContoller, strMessage: "Could not connect to the server")
            }
            else{
                
                self.showAlert(objCurrentContoller, strMessage: "Failed to Register")
                
            }
            
        }
        return boolRegister
    }
    
}