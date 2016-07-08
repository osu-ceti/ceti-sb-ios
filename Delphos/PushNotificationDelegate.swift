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
        objDeviceBean.token = gStrDeviceToken
        objDeviceBean.device_type = "ios"
        
        doPostAPIs.doRegisterDevice(objDeviceBean, callBack:{(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
               // print("Successfully registered")
//                gObjSchoolProfileController = self.instantiateVC(gStrSchoolProfileControllerID) as! SchoolProfileController
//                
//                
//                var objSchoolBean = result as! SchoolsBean
//                
//                gObjSchoolProfileController.eventBeanArray = objSchoolBean.events
//                gObjSearchSchoolListBean = objSchoolBean.school
//                gObjSchoolImage = objSchoolBean.badge_url
                // gObjSchoolProfileController .schoolImage.image = UIImage(named:"objSchoolBean.badge_url")
                
//                dispatch_async(dispatch_get_main_queue(), {
//                    
//                    var objSchoolProfileControllerNav = self.getNavigationController(gObjSchoolProfileController)
//                    //}
//                    
//                    self.doNavigate(objCurrentContoller, toController: objSchoolProfileControllerNav,  close: true)
//                })
                
            }
        })

        //)
        
    }
    
    func handleRemoteNotification(objCurrentContoller: UIViewController) {
        let pushNotificationBean = Mapper<PushNotificationBean>().map(gObjNotificationInfo)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            gBtnNotificationCount.title = String(pushNotificationBean!.data?.count)
            
            if(pushNotificationBean != nil && pushNotificationBean!.data?.n_type == "award_badge"){
                
                self.showAwardBadge((pushNotificationBean!.data?.event_name)!,
                    event_id: (pushNotificationBean!.data?.event_id)!, speaker_name: (pushNotificationBean!.data?.speaker_name)!, badge_url: (pushNotificationBean!.data?.badge_url)!)
                
                
//                let objBadgesController = self.instantiateVC(gStrBadgeControllerID) as! BadgeController
//                objBadgesController.txtEventName = pushNotificationBean!.data?.event_name
//                objBadgesController.eventId = pushNotificationBean!.data?.event_id
//                objBadgesController.txtSpeakerName = pushNotificationBean!.data?.speaker_name
//                objBadgesController.badgeUrl = pushNotificationBean!.data?.badge_url
//                
//                gObjBadgeController = self.getNavigationController(objBadgesController)
//                
//                
//                rootViewController.slideMenuController()?.changeMainViewController(gObjBadgeController, close: true)
            }
            else {
                
                gEventID = pushNotificationBean!.data?.event_id
                self.showEvent(rootViewController)
                
                
            }
        })
        
        
        
        
    }
}