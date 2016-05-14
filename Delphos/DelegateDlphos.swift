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
    func showAlert(objCurrentController: UIViewController, strMessage: String) {
        dispatch_async(dispatch_get_main_queue(), {
            let alertView = UIAlertController(title: "Error", message: strMessage, preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            objCurrentController.presentViewController(alertView, animated: true, completion: nil)
        })
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
            
        case .SHOW_EVENT:
            print("SHOW_EVENT")
            showEvent(objCurrentController)
            
        case .SEARCH_EVENT:
            print("SEARCH_EVENT")
            searchEvent(objCurrentController)


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
                self.showAlert(objCurrentContoller, strMessage: "Invalid UserName and Password")
            }
        }
        return boolLogin
    }

    func showAllEvents(objCurrentContoller: UIViewController) {
         doGetAPIs.getAllEvents { (result: AnyObject,statusCode: Int) in
            
             let eventDisplayController = objCurrentContoller as! EventDisplayController
            if(statusCode != 0){
                print("Show event")
                //var objEventDisplayBean = result as! EventDisplayBean

                dispatch_async(dispatch_get_main_queue(), {
               
                gObjEventDisplayBean = result as! EventDisplayBean
                    print("Show", objCurrentContoller)
                    
                eventDisplayController.eventBeanArray = gObjEventDisplayBean.events
                    
              //      print(eventDisplayController.eventBeanArray);
                    
                    eventDisplayController.tableView.reloadData()
                    
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
    
    func showEvent(objCurrentContoller: UIViewController) {
        var strUserDetail: String = String(gEventID)
        
        doGetAPIs.getEvent(strUserDetail,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == 200) {
                 dispatch_async(dispatch_get_main_queue(), {
                    let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("eventShowID") as! EventShowController
                    gObjShowEventBean = result as! ShowEventBean
                    objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                })
            }
        })
    }
    
    func  searchEvent(objCurrentController: UIViewController) {
        
        print(objCurrentController)
        let objEventDisplayController = objCurrentController as! EventDisplayController
        
        var strSearchText = objEventDisplayController.searchBar.text
        
        doGetAPIs.searchEvent(gBtnRadioValue!, strSearchEvent: strSearchText!, callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == 200) {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let goToSearchController = objCurrentController.storyboard?.instantiateViewControllerWithIdentifier("searchID") as! SearchController
                    if(gBtnRadioValue == "events") {
                        gObjEventDisplayBean = result as! EventDisplayBean
                         goToSearchController.eventBeanArray = gObjEventDisplayBean.events
                    } else if(gBtnRadioValue == "users") {
                        gObjUsersBean = result as! usersBean
                         goToSearchController.usersBeanArray = gObjUsersBean.users
                    }
                   
                    
                    //      print(eventDisplayController.eventBeanArray);
                     objCurrentController.presentViewController(goToSearchController, animated: true, completion: nil)
                    //objEventDisplayController.tableView.reloadData()
                    
                })

            }
        })
        
    }
    
}


