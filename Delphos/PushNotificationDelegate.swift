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
        objDeviceBean.device_name = UIDevice.currentDevice().name
        print("Device Name =" + objDeviceBean.device_name!)
        if(gStrDeviceToken != nil){
            objDeviceBean.token = gStrDeviceToken
            objDeviceBean.device_type = "ios"
        
            doPostAPIs.doRegisterDevice(objDeviceBean, callBack:{(result: AnyObject,statusCode: Int)   in
                if(statusCode == SUCCESS) {
                    print("Device Successfully registered")
                
                }
                else{
                    print("Device registration failed")
                }
            })
        }
        
    }
    
    func handleRemoteNotification(objCurrentContoller: UIViewController) {
        let pushNotificationBean = Mapper<PushNotificationBean>().map(gObjNotificationInfo)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            gBtnNotificationCount.title =  String(pushNotificationBean!.data?.count)
            
            if(pushNotificationBean != nil && pushNotificationBean!.data?.n_type == "award_badge"){
                
                
                print(rootViewController)
                self.showAwardBadge((pushNotificationBean!.data?.event_name)!,
                    event_id: (pushNotificationBean!.data?.event_id)!, speaker_name: (pushNotificationBean!.data?.speaker_name)!, badge_url: (pushNotificationBean!.data?.badge_url)!)
                
            }
            else {
                
                gEventID = pushNotificationBean!.data?.event_id
                self.showEvent(rootViewController)
                
                
            }
        })
        
        
        
        
    }
}