//
//  NotificationDelegate.swift
//  Delphos
//
//  Created by Babu on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class BadgeDelegate:BaseDelegate{
//    
//    func badgeAwardApiCall(isCheck: Bool,badgesAwardToEvent:Bool, eventId:Int, callBack: ((result: AnyObject, statusCode: Int) -> Void)?){
//        
//        doPostAPIs.postBadgesAward(badgesAwardToEvent: badgesAwardToEvent,eventId: eventId,callBack: callBack)
//    
//    }
    
    func badgesAward(_ objCurrentContoller: UIViewController) {
        
        let badgesAwardToEvent = (objCurrentContoller as! BadgeController).badgesAwardToEvent
        var eventId = (objCurrentContoller as! BadgeController).eventId
        
        //var eventId = 309
        
        
        doPostAPIs.postBadgesAward(badgesAwardToEvent!,eventId: eventId!,callBack: {(result: AnyObject,statusCode: Int)   in
           
            if(statusCode == SUCCESS) {
          
                
                DispatchQueue.main.async(execute: {
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
                
            }
        })
        
        
        
        
    }
    
    func viewAwardBadge(_ objCurrentContoller: UIViewController) {

        
        
        //(objCurrentContoller as! BadgeController).txtEventName = gEventTitle
        //        badgeAwardApiCall(true, badgesAwardToEvent: false,eventId: eventId!,callBack: {(result: AnyObject,statusCode: Int)   in

        var eventId = String(gEventID)
        var notificationId = String((objCurrentContoller as! NotificationController).notificationId)
            //String((objCurrentContoller as! NotificationController).eventId)
        doGetAPIs.getAwardBadgeDetails(eventId, notificationId: notificationId, callBack: {(result: AnyObject,statusCode: Int)   in
            
            if(statusCode == SUCCESS) {
                gObjBadgeController = self.instantiateVC(gStrBadgeControllerID) as! BadgeController
                
                
                let objAwardResponse = result as! AwardBadgesResponse
                
                if(objAwardResponse.badge_url != nil){
                
                    gObjBadgeController.badgeUrl = objAwardResponse.badge_url
 
                }
                if(objAwardResponse.event_name != nil){
                    gObjBadgeController.txtEventName = objAwardResponse.event_name

                }
                if(objAwardResponse.speaker_name != nil){
                   gObjBadgeController.txtSpeakerName = objAwardResponse.speaker_name

                }
                if(objAwardResponse.event_id != nil){
                    gObjBadgeController.eventId = objAwardResponse.event_id

                }
                if(objAwardResponse.isAwarded != nil){
                    if(objAwardResponse.isAwarded == true){
                        gObjBadgeController.isAwarded = true
                    }
                    else{
                        gObjBadgeController.isAwarded = false
                    
                    }
                }
                     gObjBadgeControllerNav = self.getNavigationController(gObjBadgeController)
                    
                DispatchQueue.main.async(execute: {
  
                    self.doNavigate(objCurrentContoller, toController: gObjBadgeControllerNav,  close: true)
                })



                
               
//                dispatch_async(dispatch_get_main_queue(), {
//                    gObjBadgeController = self.fetchNavController(gStrBadgeControllerID)
//            
//                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjBadgeController, close: false)
//                })
            }
        })

        
    }
    
    
    func showAwardedBadge(_ objCurrentContoller: BaseController) {
        
        // var strUserId: String = String(0)
        
        doGetAPIs.getAwardedBadge({(result: AnyObject,statusCode: Int)  in
            objCurrentContoller.hideOverlayView()
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            
            if(statusCode == SUCCESS) {
                gObjBackTocontroller = gObjNotificationControllerNav
                gObjViewBadgeController = self.instantiateVC(gStrViewBadgeControllerID) as! ViewBadgeController
                
                var objBadgeBean = result as! UserProfileBadgesBean
                viewBadgeBean = objBadgeBean
                
                
                DispatchQueue.main.async(execute: {
                    
                    var objViewBadgeControllerNav = self.getNavigationController(gObjViewBadgeController)
                    
                    self.doNavigate(objCurrentContoller, toController: objViewBadgeControllerNav,  close: true)
                    
                })
                
                
                
            }
            else{
                logger.log(LoggingLevel.INFO, message: " error Get view badge")
                
            }
        })
    }
    
    
}





