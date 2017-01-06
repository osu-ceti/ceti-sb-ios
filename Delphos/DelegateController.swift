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
    
    
    
    func delegateControl(_ objCurrentController: BaseController, action enmAction: DelphosAction) {
       
        logger.log(LoggingLevel.INFO, message: "Delegate(delegateControl) - Action: \(enmAction)")
        objCurrentController.showOverlay(objCurrentController.view)
        switch(enmAction)
        {
        case .login:
            logger.log(LoggingLevel.INFO, message: "Login")
            objUserDelegate.login(objCurrentController, callback: {(status:Bool)
                in
                if(status){
                    //Register Device
                    self.delegateControl(objCurrentController,action: DelphosAction.register_DEVICE)
                }
            })
            
        case .event_ALL:
            logger.log(LoggingLevel.INFO, message: "Event All")
            objEventDelegate.showAllEvents(objCurrentController)

        case .register:
            logger.log(LoggingLevel.INFO, message: "Regsiter")
            objUserDelegate.register(objCurrentController, callback: {(status:Bool)
                in
                if(status){
                    //Register Device
                    self.delegateControl(objCurrentController,action: DelphosAction.register_DEVICE)
                }
            })

            
        case .show_EVENT:
            logger.log(LoggingLevel.INFO, message: "SHOW_EVENT")
            objEventDelegate.showEvent(objCurrentController)
            
        case .search_EVENT:
            logger.log(LoggingLevel.INFO, message: "SEARCH_EVENT")
            objSearchDelegate.searchEvent(objCurrentController, isLocation: false)
            
        case .search_ZIPEVENT:
            logger.log(LoggingLevel.INFO, message: "SEARCH_EVENT")
            objSearchDelegate.searchEvent(objCurrentController, isLocation: true)
            
        case.create_EVENT:
            logger.log(LoggingLevel.INFO, message: "CREATE_EVENT")
            objEventDelegate.createEvent(objCurrentController)
            
        case .show_SEARCH:
            logger.log(LoggingLevel.INFO, message: "SHOW_SEARCH")
            objSearchDelegate.showSearch(objCurrentController)
            
        case .claim_EVENT:
            logger.log(LoggingLevel.INFO, message: "CLAIM_EVENT")
            objClaimsDelegate.claimEvent(objCurrentController)
            
        case .cancel_CLAIM:
            logger.log(LoggingLevel.INFO, message: "CANCEL CLAIM")
            objClaimsDelegate.cancelClaim(objCurrentController)
            
        case .edit_EVENT_SHOW:
            logger.log(LoggingLevel.INFO, message: "EDIT_EVENT_SHOW")
            objEventDelegate.editEvent(objCurrentController)
            
        case .cancel_EVENT:
            logger.log(LoggingLevel.INFO, message: "DELETE_EVENT")
            objEventDelegate.cancelEvent(objCurrentController)
            
        case .claim_LIST:
            logger.log(LoggingLevel.INFO, message: "claim All List ")
             objClaimsDelegate.showClaimAllList(objCurrentController)
            
        case .claim_LIST_DETAILS:
            logger.log(LoggingLevel.INFO, message: "CLAIM_LIST_DETAILS")
            objClaimsDelegate.showClaimListDetails(objCurrentController)
            
        case .claim_ACCEPT:
            logger.log(LoggingLevel.INFO, message: "CLAIM ACCEPT")
            objClaimsDelegate.claimAccept(objCurrentController)
            
        case .claim_REJECT:
            logger.log(LoggingLevel.INFO, message: "CLAIM REJECT")
             objClaimsDelegate.claimReject(objCurrentController)
        
        case .send_MESSAGE:
             logger.log(LoggingLevel.INFO, message: "SEND MESSAGE")
            objClaimsDelegate.sendMessage(objCurrentController)
            
        case .view_MESSAGE_CONTROLLER:
             logger.log(LoggingLevel.INFO, message: "VIEW MESSAGE CONTROLLER")
           objClaimsDelegate.messageClick(objCurrentController)
            
        case .show_USER_PROFILE:
             logger.log(LoggingLevel.INFO, message: "SHOW USER PROFILE")
            objUserDelegate.userProfile(objCurrentController)

        case .show_SCHOOL_PROFILE:
             logger.log(LoggingLevel.INFO, message: "SHOW SCHOOL PROFILE")
            objSchoolDelegate.schoolProfile(objCurrentController)
            
        case .sign_OUT:
             logger.log(LoggingLevel.INFO, message: "SIGN OUT")
             objUserDelegate.signOut(objCurrentController)
          
        case .show_MAKE_MY_SCHOOL:
            logger.log(LoggingLevel.INFO, message: "SHOW MAKE MY SCHOOL")
            objSchoolDelegate.showMakeMySchool(objCurrentController)
        
        case .edit_USER_PROFILE:
            logger.log(LoggingLevel.INFO, message: "EDIT USER PROFILE")
            objUserDelegate.editUserProfile(objCurrentController)
            
        case .user_PROFILE:
            logger.log(LoggingLevel.INFO, message: "Menu USER PROFILE")
            objUserDelegate.menuUserProfile(objCurrentController)
            

        case .show_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "Menu USER PROFILE")
            objNotificationDelegate.showNotification(objCurrentController)
            
            
        case .show_SHARE_BADGE:
            logger.log(LoggingLevel.INFO, message: "SHOW SHARE BADGE")
            objNotificationDelegate.showShareBadge(objCurrentController)


        case .register_DEVICE:
            logger.log(LoggingLevel.INFO, message: "Menu REGISTER DEVICE")
            objPushNotificationDelegate.registerDevice()

        case .badge_AWARD:
            logger.log(LoggingLevel.INFO, message: "BADGE AWARD")
            objBadgeDelegate.badgesAward(objCurrentController)

        case .handle_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "HANDLE NOTIFICATION")
            objPushNotificationDelegate.handleRemoteNotification(objCurrentController)

        case .view_BADGE_AWARD:
            logger.log(LoggingLevel.INFO, message: "HANDLE NOTIFICATION")
            objBadgeDelegate.viewAwardBadge(objCurrentController)
            
        case .read_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "READ NOTIFICATION")
            objNotificationDelegate.readNotification(objCurrentController)
            
        case .mark_ALL_NOTIFICATION:
            logger.log(LoggingLevel.INFO, message: "MARK ALL NOTIFICATION")
            objNotificationDelegate.deleteNotification(objCurrentController)


        case .view_SETTINGS:
            logger.log(LoggingLevel.INFO, message: "SAVE SETTINGS")
           objUserDelegate.viewSettings(objCurrentController)

        case .view_ACCOUNT_EDIT:
            logger.log(LoggingLevel.INFO, message: "VIEW ACCOUNT EDIT")
            objUserDelegate.viewAccountEdit(objCurrentController)
            
        case .edit_PROFILE_ACCOUNT:
            logger.log(LoggingLevel.INFO, message: "VIEW ACCOUNT EDIT")
            objUserDelegate.accountEdit(objCurrentController)

            
        case .save_SETTINGS:
            logger.log(LoggingLevel.INFO, message: "SAVE SETTINGS")
            objUserDelegate.saveSettings(objCurrentController)


        case .reset_FORGET_PASSWORD:
            logger.log(LoggingLevel.INFO, message: "RESET FORGET PASSWORD")
            objUserDelegate.resetPassword(objCurrentController)
            
        
//        case .AUTHENTICATE_USER:
//            logger.log(LoggingLevel.INFO, message: "AUTHENTICATE USER")
//            objUserDelegate.authenticateUserCheck(objCurrentController)
            //
            
        case .SHOW_AWARDED_BADGE:
            logger.log(LoggingLevel.INFO, message: "AWARD_NEW_BADGE")
            objBadgeDelegate.showAwardedBadge(objCurrentController)
        
        case .UNREGISTER_DEVICE:
            logger.log(LoggingLevel.INFO, message: "UNREGISTER DEVICE")
            objPushNotificationDelegate.unregisterDevice()
      
        default:
            logger.log(LoggingLevel.INFO, message: "Error in delegate enum")


        }
    }
}


