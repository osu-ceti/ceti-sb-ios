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
        case.CREATE_EVENT:
            print("CREATE_EVENT")
            createEvent(objCurrentController)
        case .SHOW_SEARCH:
            print("SHOW_SEARCH")
            showSearch(objCurrentController)
            
        case .CLAIM_EVENT:
            print("SHOW_SEARCH")
            claimEvent(objCurrentController)
            
        case .CANCEL_CLAIM:
            print("SHOW_SEARCH")
            cancelClaim(objCurrentController)
//        case .EDIT_EVENT:
//            print("Edit_Event")
//            editEvent(objCurrentController)
        default:
            print("Error in delegate enum")
        


        }
    }
    func createEvent(objCurrentContoller: UIViewController){
        let createEventController = objCurrentContoller as! CreateEventController
        let strTitle = createEventController.txtTitle.text
        let strContents = createEventController.txtContents.text
        let strTags = createEventController.txtTags.text
        let strStartDate: String = createEventController.startDate.text!
        let strStartTime: String = createEventController.startTime.text!
        let strEndDate: String = createEventController.endDate.text!
        let strEndTime: String = createEventController.endTime.text!
        var strEventStartDate =  strStartDate + "-" + strStartTime
        var strEventEndDate =  strEndDate + "-" + strEndTime
        var strEventTimeZone = createEventController.txtTimeZone.text
        var eventId = 0
        var objInputParamBean:CreateBean  = CreateBean()
       var objInputParamEventBean: CreateEventBean = CreateEventBean()
        objInputParamEventBean.title = strTitle
        objInputParamEventBean.content = strContents
        objInputParamEventBean.tag_list = strTags
        objInputParamEventBean.event_start = strEventStartDate
        objInputParamEventBean.event_end = strEventEndDate
        objInputParamEventBean.loc_id = gObjUserBean.school_id
        objInputParamEventBean.time_zone = strEventTimeZone
        objInputParamBean.event = objInputParamEventBean
        //DOA calls
        if(createEventController.isEdit){
            eventId = createEventController.eventId
        }
      
        doPostAPIs.doSaveEvent(createEventController.isEdit, eventId: eventId, objEventParam: objInputParamBean){ (result: AnyObject, statusCode: Int) in
        
            if (statusCode == 200){
                print("create event Sucessfull")
                let resultBean: CreateEventResultEventBean = result as! CreateEventResultEventBean
                gObjShowEventBean = ShowEventBean()
                gObjShowEventBean.id = resultBean.id
                gObjShowEventBean.user_id = resultBean.user_id
                gObjShowEventBean.created_at = resultBean.created_at
                gObjShowEventBean.updated_at = resultBean.updated_at
                gObjShowEventBean.content = resultBean.content
                gObjShowEventBean.title = resultBean.title
                gObjShowEventBean.event_start = resultBean.event_start
                gObjShowEventBean.event_end = resultBean.event_end
                gObjShowEventBean.loc_id = resultBean.loc_id
                gObjShowEventBean.speaker_id = resultBean.speaker_id
                gObjShowEventBean.user_name = resultBean.user_name
                gObjShowEventBean.loc_name = resultBean.loc_name
                gObjShowEventBean.active = resultBean.active
                gObjShowEventBean.time_zone = resultBean.time_zone
                gObjShowEventBean.complete = resultBean.complete
                  gObjShowEventBean.claim_id = 1
                self.showEventUI(objCurrentContoller)

                
            }
            else{
                print("create event failure")
              
            }
    
            
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
                gObjUserBean = loginResult as! UserBean
                

                boolLogin = true;
                   dispatch_async(dispatch_get_main_queue(), {
                    
                let goToEventDisplay = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("HomeID") as! HomeController
                  
                    gObjUsers = loginResult as! UserBean
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
        
        let  homeController = objCurrentContoller as! HomeController
        
        switch homeController.listType {
        case .ALL:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_ALL_EVENTS
            
        case .APPROVED:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_APPROVED
            
        case .CLAIMS:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_CLAIMS
            
        case .CONFIRMED:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_CONFIRMED
            
        default:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_ALL_EVENTS
        }
        

         doGetAPIs.getAllEvents { (result: AnyObject,statusCode: Int) in
            
             let eventDisplayController = objCurrentContoller as! HomeController
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
            if(statusCode == 200) {
                boolRegister = true
               
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let goToLoginController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("loginId") as! ViewController
                    objCurrentContoller.presentViewController(goToLoginController, animated: true, completion: nil)
                })
            }
            else{
                    self.showAlert(objCurrentContoller, strMessage: "Select Role")
            }
            
        }
        return boolRegister
    }
    
    func showEventUI(objCurrentContoller: UIViewController) {
    
        dispatch_async(dispatch_get_main_queue(), {
        let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("eventShowID") as! EventShowController
        objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
        })
    }
    
    func showEvent(objCurrentContoller: UIViewController) {
        var strUserDetail: String = String(gEventID)
        
        doGetAPIs.getEvent(strUserDetail,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == 200) {
                gObjShowEventBean = result as! ShowEventBean
                self.showEventUI(objCurrentContoller)

//                 dispatch_async(dispatch_get_main_queue(), {
//                    let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("eventShowID") as! EventShowController
//                    objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
//                })
            }
        })
    }
    
    func  searchEvent(objCurrentController: UIViewController) {
        
        print(objCurrentController)
        let objEventDisplayController = objCurrentController as! HomeController
        
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
    
    func showSearch(objCurrentContoller: UIViewController) {
        
        var strShowSearch: String = String(gSearchValue)
        
        doGetAPIs.getSearchEventsAndUsers(gBtnRadioValue, strsearchID: strShowSearch,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == 200) {
                dispatch_async(dispatch_get_main_queue(), {
                    let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("eventShowID") as! EventShowController
                    if(gBtnRadioValue == events) {
                        gObjShowEventBean = result as! ShowEventBean
                    } else if(gBtnRadioValue == schools) {
                        
                    } else if(gBtnRadioValue == users) {
                         var objUserBean = result as! usersBean
                        gObjSearchUserListBean = objUserBean.user
                    }
                    
                    objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                })
            }
        })

    }
    
    func claimEvent(objCurrentContoller: UIViewController) -> Bool {
        
      //  var objShowEventBean: ShowEventBean = ShowEventBean()
        
       // objClaimBean.user_id = gObjUsers.id
       // objClaimBean.event_id = gObjShowEventBean.user_id
        //DOA calls
        doPostAPIs.doClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            
            if (statusCode == 200){
                print("claimed")
                
                let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("HomeID") as! HomeController
                objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                
            } else {
                print("not claimed")
            }
        }
        return true
    }
    
    func cancelClaim(objCurrentContoller: UIViewController) -> Bool {
                
     //   var claimID = gObjShowEventBean.claim_id
        
        doPostAPIs.doCancelClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            if (statusCode == 200){
                print("Cancel claimed")
            } else {
                print("not claimed")
            }
        }
        
        return true
    }
//    func editEvent(objCurrentContoller: UIViewController) -> Bool {
//        
//        let goToCreateEventController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("CreateEventId") as! CreateEventController
//        objCurrentContoller.presentViewController(goToCreateEventController, animated: true, completion: nil)
//        
//
//        
//                  }

}


