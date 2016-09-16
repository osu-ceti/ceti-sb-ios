//
//  UserDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import Security


class UserDelegate:BaseDelegate{
    
    func savePassword( userNameKey:String, userPasswordKey:String){
        
        let defaultUser = NSUserDefaults.standardUserDefaults()
        let defaultPassowrd = NSUserDefaults.standardUserDefaults()
       
        defaultUser.setObject(userNameKey, forKey:"userNameKey")
    
        defaultPassowrd.setObject(userPasswordKey, forKey:"userPasswordKey")
    
    
        print(defaultPassowrd)
        print(defaultUser)
    
    }

    
    func login(objCurrentContoller: UIViewController, callback:(status: Bool)->Void) -> Bool {
        var boolLogin = false;
        let loginController = objCurrentContoller as! LoginController
        let strUser :String
        
        let strPassword:String
        
        if (NSUserDefaults.standardUserDefaults().stringForKey(gStrUserStorageKey) != nil &&
            NSUserDefaults.standardUserDefaults().stringForKey(gStrUserStoragePassKey) != nil){
            
           
             strUser = loginController.userNameData
             strPassword = loginController.userPasswordData
        }
        else{
        
         strUser = loginController.userTxt.text!
         strPassword = loginController.passwordTxt.text!
        }
        var objInputParamBean: LoginBean = LoginBean()
        var objInputParamCredsBean: CredentialsBean = CredentialsBean()
        objInputParamCredsBean.email = strUser
        objInputParamCredsBean.password = strPassword
        objInputParamCredsBean.id = 0
        objInputParamBean.user = objInputParamCredsBean
        
        let defaultPassowrd = NSUserDefaults.standardUserDefaults()
        //DOA calls
        
        doPostAPIs.doLogin(objInputParamBean){ (loginResult: AnyObject, statusCode: Int) in
            loginController.hideOverlayView()
            //self.doCleanup(statusCode, objCurrentController:loginController)
            if (statusCode == SUCCESS){

                logger.log(LoggingLevel.INFO, message: "Login Sucessfull")


                
                
                print("Login Sucessfull")
                

                loginController.activityIndicator.stopAnimating()
                loginController.overlayView.hidden = true
                
                gObjUserBean = loginResult as! UserBean
                gPasswordCheck = strPassword
                
                if(loginController.switchRememberme.on)
                {
                    
                    logger.log(LoggingLevel.INFO, message: "save data")
                    
                    logger.log(LoggingLevel.INFO, message: "switch button= \(loginController.switchRememberme.on)")
                   
                    //Save username password data
                    let userNameKey = strUser
                    let userPasswordKey = strPassword
                    self.savePassword(userNameKey,userPasswordKey:userPasswordKey)

                    
                  }
                else {

                    logger.log(LoggingLevel.INFO, message: "Data Not Saved ")
                    self.removeUserCodes()
                }
               
                boolLogin = true;
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                  
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                    
                    
                    gObjUsers = loginResult as! UserBean
                    //                   objCurrentContoller.presentViewController(goToEventDisplay, animated: true, completion: nil)
                    callback(status: true)
                })
                
                
                
            }
            else if statusCode == UNAUTHORIZED_REQUEST{
                
                logger.log(LoggingLevel.INFO, message: "Login failure")
                boolLogin = false;
                self.showAlert(objCurrentContoller, strMessage: UNAUTHORIZED_REQUEST_MSG)
                
                
                self.removeUserCodes()
                
                //loginController.activityIndicator.stopAnimating()
                //loginController.overlayView.removeFromSuperview()
                
               self.RedirectLoginPage(objCurrentContoller)
            }
            else if statusCode == BAD_REQUEST {
                logger.log(LoggingLevel.INFO, message: "Login failure")
                boolLogin = false;
                self.showAlert(objCurrentContoller, strMessage:BAD_REQUEST_MSG )
                self.removeUserCodes()
                self.RedirectLoginPage(objCurrentContoller)
                
            }
            else if statusCode == CONNECTION_FAILED {
                print("Login failure")
                boolLogin = false;
                self.showAlert(objCurrentContoller, strMessage:SERVER_ERROR_MSG )
               // self.removeUserCodes()
                self.RedirectLoginPage(objCurrentContoller)
                
            }
                
                
            else{
                logger.log(LoggingLevel.INFO, message: "Login failure")
                boolLogin = false;
                self.showAlert(objCurrentContoller, strMessage:SERVER_ERROR_MSG )
                self.removeUserCodes()
                self.RedirectLoginPage(objCurrentContoller)
            }
             callback(status: boolLogin)
            
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
            self.doCleanup(statusCode, objCurrentController:registerController)
            registerController.activityIndicator.stopAnimating()
            registerController.overlayView.removeFromSuperview()
            registerController.overlayView.hidden = true
            if(statusCode == SUCCESS) {


                logger.log(LoggingLevel.INFO, message: "Registration Successful")
                boolRegister = true

                var objUserBean = loginResult as! RegistrationResponseBean
                if(objUserBean.state == 1){
                    //Print a log
                    
                    self.showAlert(objCurrentContoller, strMessage: objUserBean.messages![0])
                    return
                }

                //let objUserBean = loginResult as! RegistrationResponseBean

                gObjUserBean = objUserBean.data
                
                
                
                let userNameKey = strEmail
                let userPasswordKey = strPassword
                self.savePassword(userNameKey!,userPasswordKey:userPasswordKey!)
                gPasswordCheck = strPassword
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.showAlert(objCurrentContoller, strMessage: SUCCESS_MSG)
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)

//                   gObjLoginController = self.self.fetchNavController(gStrLoginControllerID)
//                   
//                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: false)
                })
            }
            else if(statusCode == CONNECTION_FAILED) {
                
                
                
                self.showAlert(objCurrentContoller, strMessage: SERVER_ERROR_MSG)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    gObjRegisterController = self.fetchNavController(gStrRegisterControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjRegisterController, close: true)
                })
                
            }
            else{
                
                self.showAlert(objCurrentContoller, strMessage: REGISTERATION_ERROR)
                registerController.activityIndicator.stopAnimating()
                registerController.overlayView.hidden = true
                registerController.overlayView.removeFromSuperview()
                dispatch_async(dispatch_get_main_queue(), {
                    
                    gObjRegisterController = self.fetchNavController(gStrRegisterControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjRegisterController, close: true)
                })

            }
            
        }
        return boolRegister
    }
    
    
    func userProfile(objCurrentContoller: BaseController) {
        
        let strUserId: String = String(gUserVIewBadgeId)
      // let strUserId: String = String(strUserProfileId)
        //let strUserId: String = String((objCurrentContoller as! EventShowController).strUserId)
        
        doGetAPIs.getUserProfile(strUserId,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController: objCurrentContoller)
            if(statusCode == SUCCESS) {
                gObjUserProfileController = self.instantiateVC(gStrUserProfileControllerID) as! UserProfileController
                
                
                var objUserBean = result as! usersBean
                
                gObjUserProfileController.eventBeanArray = objUserBean.events
                gObjSearchUserListBean = objUserBean.user
                gObjUserProfileNavController = self.getNavigationController(gObjUserProfileController)
                
                dispatch_async(dispatch_get_main_queue(), {
                    gObjUserProfileController.userProfileBadgesArray = objUserBean.badges
                 })
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    self.doNavigate(objCurrentContoller, toController: gObjUserProfileNavController,  close: true)
                    
                })
                
            }
        })
    }
    
        
    
    func signOut(objCurrentContoller: BaseController) -> Bool {
        
        
        
        doPostAPIs.doSignOut(){ (SignoutResult: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if (statusCode == SUCCESS){
                logger.log(LoggingLevel.INFO, message: "sign out")
                
                NSUserDefaults.standardUserDefaults().removeObjectForKey(gStrUserStorageKey)
                NSUserDefaults.standardUserDefaults().removeObjectForKey(gStrUserStoragePassKey)
                gNotificationCount = 0
                logger.log(LoggingLevel.INFO, message: "Clear Login Data")
                gObjUserBean = nil
                var object = SignoutResult as! SignoutResponseBean
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    gObjLoginController = self.fetchNavController(gStrLoginControllerID)
                     
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                })

               
               
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    gObjLoginController = self.fetchNavController(gStrLoginControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                })
                NSUserDefaults.standardUserDefaults().removeObjectForKey(gStrUserStorageKey)
                NSUserDefaults.standardUserDefaults().removeObjectForKey(gStrUserStoragePassKey)
             logger.log(LoggingLevel.INFO, message: "Did not sign out")
            }
        }
        
        return true
    }
    func editUserProfile(objCurrentContoller: UIViewController)  {
        
        let publicProfileController = objCurrentContoller as! PublicProfileController
        
       // var strUserName = gObjMakeMySchoolListBean.name
        var strProfileId = publicProfileController.txtProfileId.text
        
        var strgrades = publicProfileController.txtProfileGrades.text
        var strBiography = publicProfileController.txtProfileBiography.text
        var strJobTitle = publicProfileController.txtProfileJobTItle.text
        var strBusiness = publicProfileController.txtProfileBusiness.text
       
       
        var objInputParamBean: MakeMySchoolListBean = MakeMySchoolListBean()
     
      
        objInputParamBean.id = Int(strProfileId!)
        objInputParamBean.grades = strgrades
        objInputParamBean.biography = strBiography
        objInputParamBean.job_title = strJobTitle
        objInputParamBean.business = strBusiness
        
       
        
        doPostAPIs.doEditProfile(objInputParamBean){ (result: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:publicProfileController)
            if(statusCode == SUCCESS) {
                logger.log(LoggingLevel.INFO, message: "Save profile")
                
                dispatch_async(dispatch_get_main_queue(), {
                    var objUserResponse = result as! EditUserProfileBean
                    
                   
                    var objectcontroller = objCurrentContoller as! PublicProfileController
                    objectcontroller.labelProfileGrades.text = objUserResponse.user.grades
                    objectcontroller.labelProfileBiography.text = objUserResponse.user.biography
                    objectcontroller.labelProfileJobTitle.text = objUserResponse.user.job_title
                    objectcontroller.labelProfileBusiness.text = objUserResponse.user.business
                   
                    if(objectcontroller.userProfileBean != nil){
                        objectcontroller.userProfileBean.grades = objUserResponse.user.grades
                        objectcontroller.userProfileBean.biography = objUserResponse.user.biography
                        objectcontroller.userProfileBean.job_title = objUserResponse.user.job_title
                        objectcontroller.userProfileBean.business = objUserResponse.user.business
                    }
                    else{
                    gObjMakeMySchoolListBean.grades = objUserResponse.user.grades
                    gObjMakeMySchoolListBean.biography = objUserResponse.user.biography
                    gObjMakeMySchoolListBean.job_title = objUserResponse.user.job_title
                    gObjMakeMySchoolListBean.business = objUserResponse.user.business
                    }
//                    
//                    gObjPublicProfileController = self.fetchNavController(gStrPublicProfileControllerID)
//                    
//                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjPublicProfileController, close: true)
//               
                })

            }
            else{
                
               logger.log(LoggingLevel.INFO, message: "NOt Save profile")
                
            }
            
        }
       
    }
    func menuUserProfile(objCurrentContoller: BaseController) {

        doGetAPIs.getMenuUserProfile( {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
               
                gObjPublicProfileController = self.instantiateVC(gStrPublicProfileControllerID) as! PublicProfileController
                
                
                let objUserBean = result as! UserBean
                gPublicEditaccountBean = result as! UserBean
                
                gObjPublicProfileController.userProfileBean = objUserBean
             
                dispatch_async(dispatch_get_main_queue(), {
                    
                    var objPublicProfileControllerNav = self.getNavigationController(gObjPublicProfileController)
                   
                    
                    self.doNavigate(objCurrentContoller, toController: objPublicProfileControllerNav,  close: true)
                    
                })
                
            }
        })
    }

    
    func viewSettings(objCurrentContoller: BaseController) {
        
        
        doGetAPIs.getSettings({(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                
                gObjSettingsController = self.instantiateVC(gStrSettingsControllerID) as! SettingsController
                

                let objSettingBean = result as! ViewSettingsResponse
                
              gObjSettingsController.settingsBean = objSettingBean
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let objSettingsControllerNav = self.getNavigationController(gObjSettingsController)
                    
                    
                    self.doNavigate(objCurrentContoller, toController: objSettingsControllerNav,  close: true)
                    
                })
                
            }
        })
    }
    
    func saveSettings(objCurrentContoller: UIViewController)  {
        
        let publicProfileController = objCurrentContoller as! SettingsController
        

        
        let objSettingsInputParamBean: SettingsListBean = SettingsListBean()
        
        
        objSettingsInputParamBean.set_updates = publicProfileController.radioEventUpdateBean
        objSettingsInputParamBean.set_confirm = publicProfileController.radioComfirmationsBean
        objSettingsInputParamBean.set_claims = publicProfileController.radioEventClaimBean
        
         let objSettingsInputBean: SettingsBean = SettingsBean()
        
        objSettingsInputBean.user = objSettingsInputParamBean
        
        doPostAPIs.doSaveSettings(objSettingsInputBean){ (result: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:publicProfileController)
            if(statusCode == SUCCESS) {
                logger.log(LoggingLevel.INFO, message: "Save Settings")
                self.showAlert(objCurrentContoller, strMessage: "Settings Saved")
                
                    
            }
              else{
                
                logger.log(LoggingLevel.INFO, message: "NOt Save Settings")
            }
        }
    }

    func viewAccountEdit(objCurrentContoller: UIViewController) {
    
       
        
        gObjAccountEditController = self.instantiateVC(gStrAccountEditControllerID) as! AccountEditController
       gObjAccountEditController.userAccountEditBean = gPublicEditaccountBean
        
        dispatch_async(dispatch_get_main_queue(), {
            
            var gObjAccountEditControllerNav = self.getNavigationController(gObjAccountEditController)
            
            
            self.doNavigate(objCurrentContoller, toController: gObjAccountEditControllerNav,  close: true)
            
        })
        
           
        
        
    }
    func resetPassword(objCurrentContoller: UIViewController)  {
        
        let loginController = objCurrentContoller as! LoginController
        
        let strResetEmail = loginController.userTxt.text
        
        
        let objResetInputParamBean: ResetPasswordListBean = ResetPasswordListBean()
        
        
        objResetInputParamBean.email = strResetEmail
        
        let objResetPasswordBean: ResetPasswordBean = ResetPasswordBean()
        
        objResetPasswordBean.utf8 = ""
        objResetPasswordBean.authenticity_token = ""
        
        objResetPasswordBean.user = objResetInputParamBean
        objResetPasswordBean.commit = "Reset Password"
        
        doPostAPIs.doResetPassword(objResetPasswordBean){ (result: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:loginController)
            
            var strMessage: String
            if(statusCode == RESET_SUCCESS) {
                
                logger.log(LoggingLevel.INFO, message: "Password Reseted")
                strMessage = "Instructions to reset your password have been sent to your email."
                
            }
        
            else{
                logger.log(LoggingLevel.INFO, message: "Password Not Changed")
                strMessage = "Failed to find your email. Please register."
            }
        

            
            loginController.activityIndicator.stopAnimating()
            loginController.overlayView.hidden = true

            
                
            dispatch_async(dispatch_get_main_queue(), {
                gObjLoginViewController = self.instantiateVC(gStrLoginControllerID) as! LoginController
                    
                gObjLoginController = self.getNavigationController(gObjLoginViewController)
                
                objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                self.showAlert(gObjLoginViewController, strMessage: strMessage)
            })
                
        }
            
        
    }

    func accountEdit(objCurrentContoller: UIViewController)  {
        
        let accountController = objCurrentContoller as! AccountEditController
        
        // var strUserName = gObjMakeMySchoolListBean.name
        let accountId = accountController.accountEditId
        let strTxtName = accountController.txtName.text
        let strTxtEmail = accountController.txtEmail.text
        let strTxtRole = accountController.txtRole
        
        let strNewpassword = accountController.txtNewPassword.text
        let strConfirmPassword = accountController.txtConfirmPassword.text
        let strCurrentPassword = accountController.txtCurrentPassword.text
        
        
        
        let objAccountInputBean: AccountEditBean = AccountEditBean()
        
        objAccountInputBean.name = strTxtName
        objAccountInputBean.email = strTxtEmail
        objAccountInputBean.password = strNewpassword
        objAccountInputBean.confirm_password = strConfirmPassword
        objAccountInputBean.current_password = strCurrentPassword
        //objAccountInputBean.id = accountId
        objAccountInputBean.role = strTxtRole
        var objAccountBean: AccountEditListBean = AccountEditListBean()
        
        objAccountBean.user = objAccountInputBean
        
        doPostAPIs.doEditProfileAccount(objAccountBean){ (result: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:accountController)
            if(statusCode == SUCCESS) {
                if(strNewpassword != ""){
                    gPasswordCheck = strNewpassword
                }
                let objEdiAccounttResult = result as! AccountEditResponseBean
                
                let objEditAccountUser = objEdiAccounttResult.user as! UserBean
                
                gObjUserBean.role = objEditAccountUser.role
                gObjUserBean.name = objEditAccountUser.name
                gObjUserBean.email = objEditAccountUser.email
                
                
                logger.log(LoggingLevel.INFO, message: "Account Edited")
                self.showAlert(objCurrentContoller, strMessage:"Account Edited")
                
                gObjPublicProfileController = self.instantiateVC(gStrPublicProfileControllerID) as! PublicProfileController
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                    
                   // var gObjPublicProfileControllerNav = self.getNavigationController(gObjPublicProfileController)
                    
                    
                   // self.doNavigate(objCurrentContoller, toController: gObjPublicProfileControllerNav,  close: true)
                    
                })
                
            }
                else{
                self.showAlert(objCurrentContoller, strMessage:"Not Account Edited ")
                logger.log(LoggingLevel.INFO, message: "Not Account Edited")
             
                
//                gObjAccountEditController = self.instantiateVC(gStrAccountEditControllerID) as! AccountEditController
//                
                dispatch_async(dispatch_get_main_queue(), {
                 (objCurrentContoller as! AccountEditController).hideOverlayView()
//                
//                    var gObjAccountEditControllerNav = self.getNavigationController(gObjAccountEditController)
//                
//                
//                    self.doNavigate(objCurrentContoller, toController: gObjAccountEditControllerNav,  close: true)
//                    
                  })

            }
        }
    }

}