//
//  NotificationDelegate.swift
//  Delphos
//
//  Created by Babu on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

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
        
        dispatch_async(dispatch_get_main_queue(), {
            gObjBadgeController = self.fetchNavController(gStrBadgeControllerID)
            
            objCurrentContoller.slideMenuController()?.changeMainViewController(gObjBadgeController, close: false)
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





