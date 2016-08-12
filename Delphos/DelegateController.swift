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
       
        logger.log(LoggingLevel.INFO, message: "Delegate(delegateControl) - Action: \(enmAction)")
        
        switch(enmAction)
        {
        case .LOGIN:
            logger.log(LoggingLevel.INFO, message: "Login")
            objUserDelegate.login(objCurrentController, callback: {(status:Bool)
                in
                if(status){
                    //Register Device
                    self.delegateControl(objCurrentController,action: DelphosAction.REGISTER_DEVICE)
                }
            })
            
        case .EVENT_ALL:
            logger.log(LoggingLevel.INFO, message: "Event All")
            objEventDelegate.showAllEvents(objCurrentController)

        case .REGISTER:
            logger.log(LoggingLevel.INFO, message: "Regsiter")
            objUserDelegate.register(objCurrentController)
            
        case .SHOW_EVENT:
            logger.log(LoggingLevel.INFO, message: "SHOW_EVENT")
            objEventDelegate.showEvent(objCurrentController)
            
        case .SEARCH_EVENT:
            logger.log(LoggingLevel.INFO, message: "SEARCH_EVENT")
            objSearchDelegate.searchEvent(objCurrentController)
            
        case.CREATE_EVENT:
            logger.log(LoggingLevel.INFO, message: "CREATE_EVENT")
            objEventDelegate.createEvent(objCurrentController)
            
        case .SHOW_SEARCH:
            logger.log(LoggingLevel.INFO, message: "SHOW_SEARCH")
            objSearchDelegate.showSearch(objCurrentController)
            
        case .CLAIM_EVENT:
            logger.log(LoggingLevel.INFO, message: "CLAIM_EVENT")
            objClaimsDelegate.claimEvent(objCurrentController)
            
        case .CANCEL_CLAIM:
            logger.log(LoggingLevel.INFO, message: "CANCEL CLAIM")
            objClaimsDelegate.cancelClaim(objCurrentController)
            
        case .EDIT_EVENT_SHOW:
            logger.log(LoggingLevel.INFO, message: "EDIT_EVENT_SHOW")
            objEventDelegate.editEvent(objCurrentController)
            
        case .CANCEL_EVENT:
            logger.log(LoggingLevel.INFO, message: "DELETE_EVENT")
            objEventDelegate.cancelEvent(objCurrentController)
            
        case .CLAIM_LIST:
            logger.log(LoggingLevel.INFO, message: "claim All List ")
             objClaimsDelegate.showClaimAllList(objCurrentController)
            
        case .CLAIM_LIST_DETAILS:
            logger.log(LoggingLevel.INFO, message: "CLAIM_LIST_DETAILS")
            objClaimsDelegate.showClaimListDetails(objCurrentController)
            
        case .CLAIM_ACCEPT:
            logger.log(LoggingLevel.INFO, message: "CLAIM ACCEPT")
            objClaimsDelegate.claimAccept(objCurrentController)
            
        case .CLAIM_REJECT:
            logger.log(LoggingLevel.INFO, message: "CLAIM REJECT")
             objClaimsDelegate.claimReject(objCurrentController)
        
        case .SEND_MESSAGE:
             logger.log(LoggingLevel.INFO, message: "SEND MESSAGE")
            objClaimsDelegate.sendMessage(objCurrentController)
            
        case .VIEW_MESSAGE_CONTROLLER:
             logger.log(LoggingLevel.INFO, message: "VIEW MESSAGE CONTROLLER")
           objClaimsDelegate.messageClick(objCurrentController)
            
        case .SHOW_USER_PROFILE:
             logger.log(LoggingLevel.INFO, message: "SHOW USER PROFILE")
            objUserDelegate.userProfile(objCurrentController)

        case .SHOW_SCHOOL_PROFILE:
             logger.log(LoggingLevel.INFO, message: "SHOW SCHOOL PROFILE")
            objSchoolDelegate.schoolProfile(objCurrentController)
            
        case .SIGN_OUT:
             logger.log(LoggingLevel.INFO, message: "SIGN OUT")
             objUserDelegate.signOut(objCurrentController)
          
        case .SHOW_MAKE_MY_SCHOOL:
            logger.log(LoggingLevel.INFO, message: "SHOW MAKE MY SCHOOL")
            objSchoolDelegate.showMakeMySchool(objCurrentController)
        
        case .EDIT_USER_PROFILE:
            logger.log(LoggingLevel.INFO, message: "EDIT USER PROFILE")
            objUserDelegate.editUserProfile(objCurrentController)
            
        case .USER_PROFILE:
            logger.log(LoggingLevel.INFO, message: "Menu USER PROFILE")
            objUserDelegate.menuUserProfile(objCurrentController)
            

        case .SHOW_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "Menu USER PROFILE")
            objNotificationDelegate.showNotification(objCurrentController)
            
            
        case .SHOW_SHARE_BADGE:
            logger.log(LoggingLevel.INFO, message: "SHOW SHARE BADGE")
            objNotificationDelegate.showShareBadge(objCurrentController)


        case .REGISTER_DEVICE:
            logger.log(LoggingLevel.INFO, message: "Menu REGISTER DEVICE")
            objPushNotificationDelegate.registerDevice()

        case .BADGE_AWARD:
            logger.log(LoggingLevel.INFO, message: "BADGE AWARD")
            objBadgeDelegate.badgesAward(objCurrentController)

        case .HANDLE_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "HANDLE NOTIFICATION")
            objPushNotificationDelegate.handleRemoteNotification(objCurrentController)

        case .VIEW_BADGE_AWARD:
            logger.log(LoggingLevel.INFO, message: "HANDLE NOTIFICATION")
            objBadgeDelegate.viewAwardBadge(objCurrentController)
            
        case .READ_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "READ NOTIFICATION")
            objNotificationDelegate.readNotification(objCurrentController)
            
        case .MARK_ALL_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "MARK ALL NOTIFICATION")
            objNotificationDelegate.deleteNotification(objCurrentController)



        case .VIEW_SETTINGS:
            logger.log(LoggingLevel.INFO, message: "SAVE SETTINGS")
           objUserDelegate.viewSettings(objCurrentController)

        case .VIEW_ACCOUNT_EDIT:
            logger.log(LoggingLevel.INFO, message: "VIEW ACCOUNT EDIT")
            objUserDelegate.viewAccountEdit(objCurrentController)
            
        case .EDIT_PROFILE_ACCOUNT:
            logger.log(LoggingLevel.INFO, message: "VIEW ACCOUNT EDIT")
            objUserDelegate.accountEdit(objCurrentController)

            
        case .SAVE_SETTINGS:
            logger.log(LoggingLevel.INFO, message: "SAVE SETTINGS")
            objUserDelegate.saveSettings(objCurrentController)


        case .RESET_FORGET_PASSWORD:
            logger.log(LoggingLevel.INFO, message: "RESET FORGET PASSWORD")
            objUserDelegate.resetPassword(objCurrentController)

            
      
        default:
            logger.log(LoggingLevel.INFO, message: "Error in delegate enum")


        }
    }
}


