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


    func showNotification(objCurrentContoller: UIViewController) {
        
        var strUserId: String = String(0)
        
        doGetAPIs.getNotification(strUserId,callBack: {(result: AnyObject,statusCode: Int)  in
            
            if(statusCode == SUCCESS) {
                //var objNotificationBean = result as! NotificationBean!
                
                gObjNotificationController = self.instantiateVC(gStrNotificationControllerID) as! NotificationController
                
                
                var objnotificationBean = result as! NotificationBean
                //(objCurrentContoller as! NotificationController).countNotification = Int(objnotificationBean.count)
                
                gNotificationCount = objnotificationBean.count
                //var notificationCount = objnotificationBean.count
                
//                if(objnotificationBean.count != nil){
//                    gNotificationCount = String(objnotificationBean.count)
//                }
//                else{
//                    gNotificationCount = "0"
//                }
                
                gObjNotificationController.notificationArray = objnotificationBean.notifications
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    var objNotificationControllerNav = self.getNavigationController(gObjNotificationController)
                    
                    self.doNavigate(objCurrentContoller, toController: objNotificationControllerNav,  close: true)
                    
                })
                
                
                
                
            }else{
                print(" error Get Notification")
            }
        })
    }
func showShareBadge(objCurrentContoller: UIViewController) {
        
       // var strUserId: String = String(0)
        
        doGetAPIs.getShareBadge({(result: AnyObject,statusCode: Int)  in
            
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
                print(" error Get view badge")

            }
        })
    }

func deleteNotification(objCurrentContoller: UIViewController)  {
        
       
        
        doPostAPIs.doDeleteNotification({(result: AnyObject,statusCode: Int)   in
           
            if(statusCode == SUCCESS) {
                
                print("MARK ALL Notification AS READ")
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
                 print("NOT MARK ALL Notification AS READ")
                //self.showAlert(objCurrentContoller, strMessage: "NOT MARK ALL Notification AS READ")
            }
        })
        
        
    }



}