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
    
    
    
    func badgesAward(_ objCurrentContoller: UIViewController) {
        
        var badgesAwardToEvent = (objCurrentContoller as! BadgeController).badgesAwardToEvent
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

        
       // (objCurrentContoller as! BadgeController).txtSpeakerName = gActUserName
        //(objCurrentContoller as! BadgeController).txtEventName = gEventTitle
        
        DispatchQueue.main.async(execute: {
            gObjBadgeController = self.fetchNavController(gStrBadgeControllerID)
            
            objCurrentContoller.slideMenuController()?.changeMainViewController(gObjBadgeController, close: false)
        })

        
    }
    
    

    
    
}





