	//
//  PushNotificationDelegate.swift
//  Delphos
//
//  Created by lingaadm on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class PushNotificationDelegate: BaseDelegate {

    func registerDevice(){
        let objDeviceBean = DeviceBean()
        objDeviceBean.device_name = UIDevice.current.name
        logger.log(LoggingLevel.INFO
            , message: "Device Name =" + objDeviceBean.device_name!)
        if(gStrDeviceToken != nil){
            objDeviceBean.token = gStrDeviceToken
            objDeviceBean.device_type = "ios"
        
            doPostAPIs.doRegisterDevice(objDeviceBean, callBack:{(result: AnyObject,statusCode: Int)   in
                if(statusCode == SUCCESS) {
                    logger.log(LoggingLevel.INFO, message: "Device Successfully registered")
                
                }
                else{
                    logger.log(LoggingLevel.INFO, message: "Device registration failed")
                }
            })
        }
        
    }
    
    func handleRemoteNotification(_ objCurrentContoller: UIViewController) {
        
        if let authkey = userCredsStorage.string(forKey: gAuthenticationKey) {
        
        let pushNotificationBean = Mapper<PushNotificationBean>().map(JSON: gObjNotificationInfo as! [String: Any])
        
            DispatchQueue.main.async(execute: {
                
                // var titleCount = String(pushNotificationBean!.data?.count)
                
                
                gBtnNotificationCount.title = String(pushNotificationBean!.data!.count)
                
                
                //gBtnNotificationCount.title = titleCount
                
                if(pushNotificationBean != nil && pushNotificationBean!.data?.n_type == "award_badge"){
                    
                    
                    self.showAwardBadge((pushNotificationBean!.data?.event_name)!,
                                        event_id: (pushNotificationBean!.data?.event_id)!, speaker_name: (pushNotificationBean!.data?.speaker_name)!, badge_url: (pushNotificationBean!.data?.badge_url)!)
                    
                }
                
                //            else {
                //                 let objBadgesController = self.instantiateVC(gStrBadgeControllerID) as! BadgeController
                //
                //                gObjBadgeController = self.getNavigationController(objBadgesController)
                //
                //
                //                rootViewController.slideMenuController()?.changeMainViewController(gObjBadgeController, close: true)
                //
                ////                gEventID = pushNotificationBean!.data?.event_id
                ////                self.showEvent(rootViewController)
                //                
                //                
                //            }
            })
        }
        else{
            logger.log(LoggingLevel.INFO, message: "Auth token is not store in local storage")

        }
        
        
        
    }
    
    func unregisterDevice(){
        let objDeviceBean = DeviceBean()
        objDeviceBean.device_name = UIDevice.current.name
        logger.log(LoggingLevel.INFO
            , message: "Device Name =" + objDeviceBean.device_name!)
        if(gStrDeviceToken != nil){
            objDeviceBean.token = gStrDeviceToken
            objDeviceBean.device_type = "ios"
            
            doPostAPIs.doUnregisterDevice(objDeviceBean, callBack:{(result: AnyObject,statusCode: Int)   in
                if(statusCode == SUCCESS) {
                    logger.log(LoggingLevel.INFO, message: "Device Successfully remove registered")
                    
                }
                else{
                    logger.log(LoggingLevel.INFO, message: "Device remove registration failed")
                }
            })
        }
        
    }
}
