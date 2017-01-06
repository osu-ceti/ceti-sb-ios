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
    
    func saveInLocalStorageIfPresent(key: String, value: AnyObject){
        if(value != nil){
            userCredsStorage.set(value, forKey:key)
        }
    }
    
    func saveInLocalStorage(){
        
        
        //print("Auth",defaultAuth)
        
        
        if(gObjUserBean != nil){
            print(gObjUserBean)
            if(gObjUserBean.authentication_token != nil){
                saveInLocalStorageIfPresent(key: gAuthenticationKey, value: gObjUserBean.authentication_token as    AnyObject)
            }
            if(gObjUserBean.email != nil){
                saveInLocalStorageIfPresent(key: gEmailKey, value: gObjUserBean.email as AnyObject)
            }
            if(gObjUserBean.biography != nil){
                saveInLocalStorageIfPresent(key: gBiographyKey, value: gObjUserBean.biography as AnyObject)
            }
            if(gObjUserBean.business != nil){
                saveInLocalStorageIfPresent(key: gBusinessKey, value: gObjUserBean.business as AnyObject)
            }
            if(gObjUserBean.id != nil){
                saveInLocalStorageIfPresent(key: gIdKey, value: gObjUserBean.id as AnyObject)
            }
            if(gObjUserBean.job_title != nil){
                saveInLocalStorageIfPresent(key: gJobTitleKey, value: gObjUserBean.job_title as AnyObject)
            }
            if(gObjUserBean.name != nil){
                saveInLocalStorageIfPresent(key: gNameKey, value: gObjUserBean.name as AnyObject)
            }
            if(gObjUserBean.role != nil){
                saveInLocalStorageIfPresent(key: gRolekey, value: gObjUserBean.role as AnyObject)
            }
            if(gObjUserBean.school_id != nil){
                saveInLocalStorageIfPresent(key: gSchoolIdKey, value: gObjUserBean.school_id as AnyObject)
            }
            if(gObjUserBean.school_name != nil){
                saveInLocalStorageIfPresent(key: gSchoolNameKey, value: gObjUserBean.school_name as AnyObject)
            }
           
            
        }
    
    }
    
  
    
    func login(_ objCurrentContoller: UIViewController, callback:@escaping (_ status: Bool)->Void) -> Bool {
        var boolLogin = false;
        let loginController = objCurrentContoller as! LoginController
        let strUser :String
        
        let strPassword:String
       
        
        strUser = loginController.userTxt.text!
        strPassword = loginController.passwordTxt.text!
        
        var objInputParamBean: LoginBean = LoginBean()
        var objInputParamCredsBean: CredentialsBean = CredentialsBean()
        objInputParamCredsBean.email = strUser
        objInputParamCredsBean.password = strPassword
        objInputParamCredsBean.id = 0
        objInputParamBean.user = objInputParamCredsBean
        
        let defaultPassowrd = userCredsStorage
        //DOA calls
        
        doPostAPIs.doLogin(objInputParamBean){ (loginResult: AnyObject, statusCode: Int) in
            loginController.hideOverlayView()
            //self.doCleanup(statusCode, objCurrentController:loginController)
            if (statusCode == SUCCESS){

                logger.log(LoggingLevel.INFO, message: "Login Sucessfull")


                
                
                print("Login Sucessfull")
                

                loginController.activityIndicator.stopAnimating()
                loginController.overlayView.isHidden = true
                
                gObjUserBean = loginResult as! UserBean
                gPasswordCheck = strPassword
                
                self.saveInLocalStorageIfPresent(key: gStrUserStoragePassKey, value: gPasswordCheck as AnyObject)
                if(loginController.switchRememberme.isOn)
                {
                    
                    logger.log(LoggingLevel.INFO, message: "save data")
                    
                    logger.log(LoggingLevel.INFO, message: "switch button= \(loginController.switchRememberme.isOn)")
                   
                    //Save username password data
                    let userNameKey = strUser
                    let userPasswordKey = strPassword
                    let authToken = gObjUserBean.authentication_token
                    self.saveInLocalStorage()
                    
                    
                  }
                else {

                    logger.log(LoggingLevel.INFO, message: "Data Not Saved ")
                    self.removeUserCodes()
                }
               
                boolLogin = true;
                
                DispatchQueue.main.async(execute: {
                    
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                  
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                    
                    
                    gObjUsers = loginResult as! UserBean
                    //                   objCurrentContoller.presentViewController(goToEventDisplay, animated: true, completion: nil)
                    callback(true)
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
             callback(boolLogin)
            
        }
        return boolLogin
    }
    
    
    
    
    func register(_ objCurrentContoller: UIViewController, callback:@escaping (_ status: Bool)->Void) -> Bool{
        
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
            registerController.overlayView.isHidden = true
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
                let authToken = gObjUserBean.authentication_token
                self.saveInLocalStorage()
                
                gPasswordCheck = strPassword
                self.saveInLocalStorageIfPresent(key: gStrUserStoragePassKey, value: gPasswordCheck as AnyObject)
                DispatchQueue.main.async(execute: {
                    self.showAlert(objCurrentContoller, strMessage: SUCCESS_MSG)
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                    callback(true)
                    

//                   gObjLoginController = self.self.fetchNavController(gStrLoginControllerID)
//                   
//                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: false)
                })
            }
            else if(statusCode == CONNECTION_FAILED) {
                
                
                
                self.showAlert(objCurrentContoller, strMessage: SERVER_ERROR_MSG)
                DispatchQueue.main.async(execute: {
                    
                    gObjRegisterController = self.fetchNavController(gStrRegisterControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjRegisterController, close: true)
                    callback(false)
                })
                
            }
            else{
                
                self.showAlert(objCurrentContoller, strMessage: REGISTERATION_ERROR)
                registerController.activityIndicator.stopAnimating()
                registerController.overlayView.isHidden = true
                registerController.overlayView.removeFromSuperview()
                DispatchQueue.main.async(execute: {
                    
                    gObjRegisterController = self.fetchNavController(gStrRegisterControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjRegisterController, close: true)
                    callback(false)
                })

            }
            
        }
        return boolRegister
    }
    
    
    func userProfile(_ objCurrentContoller: BaseController) {
        
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
                
                DispatchQueue.main.async(execute: {
                    gObjUserProfileController.userProfileBadgesArray = objUserBean.badges
                 })
                
                DispatchQueue.main.async(execute: {
                    
                    
                    self.doNavigate(objCurrentContoller, toController: gObjUserProfileNavController,  close: true)
                    
                })
                
            }
        })
    }
    
        
    
    func signOut(_ objCurrentContoller: BaseController) -> Bool {
        
        userCredsStorage.removeObject(forKey: gStrUserStorageKey)
        userCredsStorage.removeObject(forKey: gStrUserStoragePassKey)
        userCredsStorage.removeObject(forKey: gAuthenticationKey)
        
        doPostAPIs.doSignOut(){ (SignoutResult: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            
            if (statusCode == SUCCESS){
                logger.log(LoggingLevel.INFO, message: "sign out")
                
                
                gNotificationCount = 0
                logger.log(LoggingLevel.INFO, message: "Clear Login Data")
                gObjUserBean = nil
                var object = SignoutResult as! SignoutResponseBean
                
                DispatchQueue.main.async(execute: {
                    
                    gObjLoginController = self.fetchNavController(gStrLoginControllerID)
                     
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                })

               
               
            } else {
                DispatchQueue.main.async(execute: {
                    
                    gObjLoginController = self.fetchNavController(gStrLoginControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                })

             logger.log(LoggingLevel.INFO, message: "Did not sign out")
            }
        }
        
        return true
    }
    func editUserProfile(_ objCurrentContoller: UIViewController)  {
        
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
                
                DispatchQueue.main.async(execute: {
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
    func menuUserProfile(_ objCurrentContoller: BaseController) {

        doGetAPIs.getMenuUserProfile( {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
               
                gObjPublicProfileController = self.instantiateVC(gStrPublicProfileControllerID) as! PublicProfileController
                
                
                let objUserBean = result as! UserBean
                gPublicEditaccountBean = result as! UserBean
                
                gObjPublicProfileController.userProfileBean = objUserBean
             
                DispatchQueue.main.async(execute: {
                    
                    var objPublicProfileControllerNav = self.getNavigationController(gObjPublicProfileController)
                   
                    
                    self.doNavigate(objCurrentContoller, toController: objPublicProfileControllerNav,  close: true)
                    
                })
                
            }
        })
    }

    
    func viewSettings(_ objCurrentContoller: BaseController) {
        
        
        doGetAPIs.getSettings({(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                
                gObjSettingsController = self.instantiateVC(gStrSettingsControllerID) as! SettingsController
                

                let objSettingBean = result as! ViewSettingsResponse
                
              gObjSettingsController.settingsBean = objSettingBean
                
                DispatchQueue.main.async(execute: {
                    
                    let objSettingsControllerNav = self.getNavigationController(gObjSettingsController)
                    
                    
                    self.doNavigate(objCurrentContoller, toController: objSettingsControllerNav,  close: true)
                    
                })
                
            }
        })
    }
    
    func saveSettings(_ objCurrentContoller: UIViewController)  {
        
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

    func viewAccountEdit(_ objCurrentContoller: UIViewController) {
    
       
        
        gObjAccountEditController = self.instantiateVC(gStrAccountEditControllerID) as! AccountEditController
       gObjAccountEditController.userAccountEditBean = gPublicEditaccountBean
        
        DispatchQueue.main.async(execute: {
            
            var gObjAccountEditControllerNav = self.getNavigationController(gObjAccountEditController)
            
            
            self.doNavigate(objCurrentContoller, toController: gObjAccountEditControllerNav,  close: true)
            
        })
        
           
        
        
    }
    func resetPassword(_ objCurrentContoller: UIViewController)  {
        
        let loginController = objCurrentContoller as! LoginController
        
        let strResetEmail = loginController.userTxt.text
        
        
        let objResetInputParamBean: ResetPasswordListBean = ResetPasswordListBean()
        
        
        objResetInputParamBean.email = strResetEmail
        
        let objResetPasswordBean: ResetPasswordBean = ResetPasswordBean()
        
        objResetPasswordBean.utf8 = DelphosStrings.EMPTY_STRING
        objResetPasswordBean.authenticity_token = DelphosStrings.EMPTY_STRING
        
        objResetPasswordBean.user = objResetInputParamBean
        objResetPasswordBean.commit = "Reset Password"
        
        doPostAPIs.doResetPassword(objResetPasswordBean){ (result: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:loginController)
            if(statusCode == RESET_SUCCESS) {
                
                logger.log(LoggingLevel.INFO, message: "Password Reseted")
                
                loginController.activityIndicator.stopAnimating()
                loginController.overlayView.isHidden = true

                self.showAlert(objCurrentContoller, strMessage: "Please check your email")
                
                
            }
            else{
                 self.showAlert(objCurrentContoller, strMessage: "Password Not Changed please try again later")
                
                 logger.log(LoggingLevel.INFO, message: "Password Not Changed")
                
                
            }
            DispatchQueue.main.async(execute: {
                
                gObjLoginController = self.fetchNavController(gStrLoginControllerID)
                
                objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
                
                
                
            })

            
        }
    }

    func accountEdit(_ objCurrentContoller: UIViewController)  {
        
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
                if(strNewpassword != DelphosStrings.EMPTY_STRING){
                    gPasswordCheck = strNewpassword
                    self.saveInLocalStorageIfPresent(key: gStrUserStoragePassKey, value: gPasswordCheck as AnyObject)
                }
                let objEdiAccounttResult = result as! AccountEditResponseBean
                
                let objEditAccountUser = objEdiAccounttResult.user as! UserBean
                
                gObjUserBean.role = objEditAccountUser.role
                gObjUserBean.name = objEditAccountUser.name
                gObjUserBean.email = objEditAccountUser.email
                
                self.saveInLocalStorageIfPresent(key: gRolekey, value: objEditAccountUser.role  as AnyObject)
               
                self.saveInLocalStorageIfPresent(key: gNameKey, value: objEditAccountUser.name as AnyObject)
                self.saveInLocalStorageIfPresent(key:gEmailKey, value: objEditAccountUser.email as AnyObject)
               
                
                
                logger.log(LoggingLevel.INFO, message: "Account Edited")
                self.showAlert(objCurrentContoller, strMessage:"Account Edited")
                
                gObjPublicProfileController = self.instantiateVC(gStrPublicProfileControllerID) as! PublicProfileController
                
                DispatchQueue.main.async(execute: {
                    
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
                DispatchQueue.main.async(execute: {
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
