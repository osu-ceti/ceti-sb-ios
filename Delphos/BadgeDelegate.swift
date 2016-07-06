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
        })
        
        
        
        
    }
    
    func badgesAward(objCurrentContoller: UIViewController) {
        
        var strSchoolId = String(0)
        doPostAPIs.postBadgesAward(strSchoolId,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                
                
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    gObjBadgeController = self.fetchNavController(gStrBadgeControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjBadgeController, close: false)
                })
                
            }
        })
        
        
        
        
    }
    
}





