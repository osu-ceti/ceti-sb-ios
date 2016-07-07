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
    
    func viewBadgesAward(objCurrentContoller: UIViewController) {
        
        //        var strSchoolId = String(0)
        //        doGetAPIs.getAwardbadges(strSchoolId,callBack: {(result: AnyObject,statusCode: Int)   in
        //            if(statusCode == SUCCESS) {
        //
        //
        //
        //
        //
        //
        //                dispatch_async(dispatch_get_main_queue(), {
        //                   gObjBadgesAwardController = self.fetchNavController(gStrBadgesAwardControllerID)
        //
        //                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjBadgesAwardController, close: false)
        //                })
        //
        //            }
        //        })
        
        let pushNotificationBean = Mapper<PushNotificationBean>().map(gObjNotificationInfo)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            if(pushNotificationBean != nil && pushNotificationBean!.data?.n_type == "award_badge"){
                let objBadgesController = self.instantiateVC(gStrBadgeControllerID) as! BadgeController
                objBadgesController.txtEventName = pushNotificationBean!.data?.event_name
                objBadgesController.eventId = pushNotificationBean!.data?.event_id
                objBadgesController.txtSpeakerName = pushNotificationBean!.data?.speaker_name
                objBadgesController.badgeUrl = pushNotificationBean!.data?.badge_url
            
                gObjBadgeController = self.getNavigationController(objBadgesController)
                
            
                rootViewController.slideMenuController()?.changeMainViewController(gObjBadgeController, close: true)
            }
            else {
                let objBadgesController = self.instantiateVC(gStrBadgeControllerID) as! BadgeController
                objBadgesController.txtEventName = "test"
                objBadgesController.eventId = 3
                objBadgesController.txtSpeakerName = "speaker"
                objBadgesController.badgeUrl = "def_school_badge_small.jpg"
                gObjBadgeController = self.getNavigationController(objBadgesController)
                
                
                rootViewController.slideMenuController()?.changeMainViewController(gObjBadgeController, close: true)
            
            }
        })
        
        
        
        
    }
    
    func badgesAward(objCurrentContoller: UIViewController) {
        
        var badgesAwardToEvent = (objCurrentContoller as! BadgeController).badgesAwardToEvent
        var eventId = (objCurrentContoller as! BadgeController).eventId
        
        doPostAPIs.postBadgesAward(badgesAwardToEvent,eventId: eventId!,callBack: {(result: AnyObject,statusCode: Int)   in
           
            if(statusCode == SUCCESS) {
          
                
                dispatch_async(dispatch_get_main_queue(), {
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
                
            }
        })
        
        
        
        
    }
    
}





