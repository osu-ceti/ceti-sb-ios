//
//  NotificationDelegate.swift
//  Delphos
//
//  Created by Babu on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation


import UIKit


class NotificationDelegate:BaseDelegate{


    func showNotification(objCurrentContoller: BaseController) {
        
        
        doGetAPIs.getNotification( {(result: AnyObject,statusCode: Int)  in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            
            if(statusCode == SUCCESS) {
                //var objNotificationBean = result as! NotificationBean!
                
                
                gObjNotificationController = self.instantiateVC(gStrNotificationControllerID) as! NotificationController
                
                
                let objnotificationBean = result as! NotificationBean
   
                
                gNotificationCount = objnotificationBean.count
                
                
                gObjNotificationController.notificationArray = objnotificationBean.notifications
                
                dispatch_async(dispatch_get_main_queue(), {
                  
                    
                    var objNotificationControllerNav = self.getNavigationController(gObjNotificationController)
                    
                    self.doNavigate(objCurrentContoller, toController: objNotificationControllerNav,  close: true)
                    
                })
                
                
                
                
            }else{
                logger.log(LoggingLevel.INFO, message: " error Get Notification")
            }
        })
    }
func showShareBadge(objCurrentContoller: BaseController) {
        
       // var strUserId: String = String(0)
        
        doGetAPIs.getShareBadge({(result: AnyObject,statusCode: Int)  in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            
            if(statusCode == SUCCESS) {
                
                 gObjViewBadgeController = self.instantiateVC(gStrViewBadgeControllerID) as! ViewBadgeController
               
                var objBadgeBean = result as! UserProfileBadgesBean
                viewBadgeBean = objBadgeBean
              
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                      var objViewBadgeControllerNav = self.getNavigationController(gObjViewBadgeController)
                    
                    self.doNavigate(objCurrentContoller, toController: objViewBadgeControllerNav,  close: true)
                    
                })

                
                
            }
            else{
                logger.log(LoggingLevel.INFO, message: " error Get view badge")

            }
        })
    }

func deleteNotification(objCurrentContoller: BaseController)  {
        
       
        
        doPostAPIs.doDeleteNotification({(result: AnyObject,statusCode: Int)   in
           self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                
                logger.log(LoggingLevel.INFO, message: "MARK ALL Notification AS READ")
               // self.showAlert(objCurrentContoller, strMessage: "Claim Rejected")
                
//                dispatch_async(dispatch_get_main_queue(), {
//                    
//                    gObjNotificationControllerNav = self.fetchNavController(gStrNotificationControllerID)
//                    
//                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjNotificationControllerNav, close: true)
//                   
//                })
                
                
            }
            else{
                 logger.log(LoggingLevel.INFO, message: "NOT MARK ALL Notification AS READ")
                //self.showAlert(objCurrentContoller, strMessage: "NOT MARK ALL Notification AS READ")
            }
        })
        
        
    }
    func readNotification(objCurrentContoller: BaseController)  {
        
        var strid = String((objCurrentContoller as! NotificationController).notificationId)
        
        doPostAPIs.doReadNotification(strid){ (result: AnyObject, statusCode: Int)  in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                    //Left Empty for future Use
            }
            else{
               //Left Empty for future Use
            }
       
        
        
    }


    }

}