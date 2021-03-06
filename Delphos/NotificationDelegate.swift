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


    func showNotification(_ objCurrentContoller: BaseController) {
        
        var pageValue:String!
       
        pageValue = String(notificationPage)
        
        doGetAPIs.getNotification(pageValue!, callBack: {(result: AnyObject,statusCode: Int)  in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            
            if(statusCode == SUCCESS) {
                //var objNotificationBean = result as! NotificationBean!
                
                
                
                gObjNotificationController = self.instantiateVC(gStrNotificationControllerID) as! NotificationController
               
                
                
                let objnotificationBean = result as! NotificationBean
   
                
                gNotificationCount = objnotificationBean.count
               // var firstArray: [NotificationListBean]
               // var secondArray:[NotificationListBean]
                var finalArray: [NotificationListBean]
                
                if(notificationPage == 1){
                    
                     NotificationFirstArray = objnotificationBean.notifications
                     gObjNotificationController.notificationArray = objnotificationBean.notifications
                }
                else{
                    
                    NotificationSecondArray = objnotificationBean.notifications
                    finalArray = NotificationFirstArray + NotificationSecondArray
                    
                    gObjNotificationController.notificationArray = finalArray
                    NotificationFirstArray = finalArray
                   
                  
                }
                
                
                
                DispatchQueue.main.async(execute: {
                  
                    
                     gObjNotificationControllerNav = self.getNavigationController(gObjNotificationController)
                    
                    self.doNavigate(objCurrentContoller, toController: gObjNotificationControllerNav,  close: true)
                    
                })
                
                
                
                
            }else{
                logger.log(LoggingLevel.INFO, message: " error Get Notification")
            }
        })
    }
func showShareBadge(_ objCurrentContoller: BaseController) {
        
       // var strUserId: String = String(0)
        
        doGetAPIs.getShareBadge({(result: AnyObject,statusCode: Int)  in
            objCurrentContoller.hideOverlayView()
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            
            if(statusCode == SUCCESS) {
                gObjBackTocontroller = gObjUserProfileNavController
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

func deleteNotification(_ objCurrentContoller: BaseController)  {
        
       
        
        doPostAPIs.doDeleteNotification({(result: AnyObject,statusCode: Int)   in
           self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                
                logger.log(LoggingLevel.INFO, message: "MARK ALL Notification AS READ")
                notificationPage = 1;
                self.showNotification(objCurrentContoller)
                

                
            }
            else{
                 logger.log(LoggingLevel.INFO, message: "NOT MARK ALL Notification AS READ")
                //self.showAlert(objCurrentContoller, strMessage: "NOT MARK ALL Notification AS READ")
            }
        })
        
        
    }
    func readNotification(_ objCurrentContoller: BaseController)  {
        
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
