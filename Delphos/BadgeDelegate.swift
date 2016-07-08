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
    
    func viewAwardBadge(objCurrentContoller: UIViewController) {
//        
//        self.showAwardBadge((pushNotificationBean!.data?.event_name)!,
//                            event_id: (pushNotificationBean!.data?.event_id)!, speaker_name: (pushNotificationBean!.data?.speaker_name)!, badge_url: (pushNotificationBean!.data?.badge_url)!)
        
        
    }
    
    

    
    
}





