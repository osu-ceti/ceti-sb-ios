//
//  DelegateDlphos.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * Delegate class that delegates control to all Models.
 */
class DelegateController: BaseDelegate {
    
    
    var rootController : UINavigationController!
    var objEventDelegate : EventDelegate!
    var objClaimsDelegate : ClaimsDelegate!
    var objUserDelegate : UserDelegate!
    var objSearchDelegate : SearchDelegate!
    var objSchoolDelegate : SchoolDelegate!
    var objNotificationDelegate : NotificationDelegate!
    var objPushNotificationDelegate : PushNotificationDelegate!
    var objBadgeDelegate : BadgeDelegate!

    
    override init() {
        
        
        objEventDelegate = EventDelegate()
        objClaimsDelegate = ClaimsDelegate()
        objUserDelegate = UserDelegate()
        objSearchDelegate = SearchDelegate()
        objSchoolDelegate = SchoolDelegate()

        objNotificationDelegate = NotificationDelegate()

        objPushNotificationDelegate = PushNotificationDelegate()
        objBadgeDelegate = BadgeDelegate()


    }
    
    
    
    func delegateControl(objCurrentController: UIViewController, action enmAction: DelphosAction) {
       
        print("Delegate(delegateControl) - Action: \(enmAction)")
        
        switch(enmAction)
        {
        case .LOGIN:
            print("Login")
            objUserDelegate.login(objCurrentController, callback: {(status:Bool)
                in
                if(status){
                    //Register Device
                    self.delegateControl(objCurrentController,action: DelphosAction.REGISTER_DEVICE)
                }
            })
            
        case .EVENT_ALL:
            print("Event All")
            objEventDelegate.showAllEvents(objCurrentController)

        case .REGISTER:
            print("Regsiter")
            objUserDelegate.register(objCurrentController)
            
        case .SHOW_EVENT:
            print("SHOW_EVENT")
            objEventDelegate.showEvent(objCurrentController)
            
        case .SEARCH_EVENT:
            print("SEARCH_EVENT")
            objSearchDelegate.searchEvent(objCurrentController)
            
        case.CREATE_EVENT:
            print("CREATE_EVENT")
            objEventDelegate.createEvent(objCurrentController)
            
        case .SHOW_SEARCH:
            print("SHOW_SEARCH")
            objSearchDelegate.showSearch(objCurrentController)
            
        case .CLAIM_EVENT:
            print("CLAIM_EVENT")
            objClaimsDelegate.claimEvent(objCurrentController)
            
        case .CANCEL_CLAIM:
            print("CANCEL CLAIM")
            objClaimsDelegate.cancelClaim(objCurrentController)
            
        case .EDIT_EVENT_SHOW:
            print("EDIT_EVENT_SHOW")
            objEventDelegate.editEvent(objCurrentController)
            
        case .CANCEL_EVENT:
            print("DELETE_EVENT")
            objEventDelegate.cancelEvent(objCurrentController)
            
        case .CLAIM_LIST:
            print("claim All List ")
             objClaimsDelegate.showClaimAllList(objCurrentController)
            
        case .CLAIM_LIST_DETAILS:
            print("CLAIM_LIST_DETAILS")
            objClaimsDelegate.showClaimListDetails(objCurrentController)
            
        case .CLAIM_ACCEPT:
            print("CLAIM ACCEPT")
            objClaimsDelegate.claimAccept(objCurrentController)
            
        case .CLAIM_REJECT:
            print("CLAIM REJECT")
             objClaimsDelegate.claimReject(objCurrentController)
        
        case .SEND_MESSAGE:
             print("SEND MESSAGE")
            objClaimsDelegate.sendMessage(objCurrentController)
            
        case .VIEW_MESSAGE_CONTROLLER:
             print("VIEW MESSAGE CONTROLLER")
           objClaimsDelegate.messageClick(objCurrentController)
            
        case .SHOW_USER_PROFILE:
             print("SHOW USER PROFILE")
            objUserDelegate.userProfile(objCurrentController)

        case .SHOW_SCHOOL_PROFILE:
             print("SHOW SCHOOL PROFILE")
            objSchoolDelegate.schoolProfile(objCurrentController)
            
        case .SIGN_OUT:
             print("SIGN OUT")
             objUserDelegate.signOut(objCurrentController)
          
        case .SHOW_MAKE_MY_SCHOOL:
            print("SHOW MAKE MY SCHOOL")
            objSchoolDelegate.showMakeMySchool(objCurrentController)
        
        case .EDIT_USER_PROFILE:
            print("EDIT USER PROFILE")
            objUserDelegate.editUserProfile(objCurrentController)
            
        case .USER_PROFILE:
            print("Menu USER PROFILE")
            objUserDelegate.menuUserProfile(objCurrentController)
            

        case .SHOW_NOTIFICATION:
            print("Menu USER PROFILE")
            objNotificationDelegate.showNotification(objCurrentController)
            
            
        case .SHOW_SHARE_BADGE:
            print("SHOW SHARE BADGE")
            objNotificationDelegate.showShareBadge(objCurrentController)


        case .REGISTER_DEVICE:
            print("Menu REGISTER DEVICE")
            objPushNotificationDelegate.registerDevice()

        case .BADGE_AWARD:
            print("BADGE AWARD")
            objBadgeDelegate.badgesAward(objCurrentController)

        case .HANDLE_NOTIFICATION:
            print("HANDLE NOTIFICATION")
            objPushNotificationDelegate.handleRemoteNotification(objCurrentController)

        case .VIEW_BADGE_AWARD:
            print("HANDLE NOTIFICATION")
            objBadgeDelegate.viewAwardBadge(objCurrentController)
            
        case .READ_NOTIFICATION:
            print("READ NOTIFICATION")
            objNotificationDelegate.readNotification(objCurrentController)
            
        case .MARK_ALL_NOTIFICATION:
            print("MARK ALL NOTIFICATION")
            objNotificationDelegate.deleteNotification(objCurrentController)



        case .VIEW_SETTINGS:
            print("SAVE SETTINGS")
           objUserDelegate.viewSettings(objCurrentController)

        case .VIEW_ACCOUNT_EDIT:
            print("VIEW ACCOUNT EDIT")
            objUserDelegate.viewAccountEdit(objCurrentController)
            
        case .EDIT_PROFILE_ACCOUNT:
            print("VIEW ACCOUNT EDIT")
            objUserDelegate.accountEdit(objCurrentController)

            
        case .SAVE_SETTINGS:
            print("SAVE SETTINGS")
            objUserDelegate.saveSettings(objCurrentController)


        case .RESET_FORGET_PASSWORD:
            print("RESET FORGET PASSWORD")
            objUserDelegate.resetPassword(objCurrentController)

            
      
        default:
            print("Error in delegate enum")


        }
    }
}


