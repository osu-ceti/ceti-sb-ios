//
//  PushNotificationDelegate.swift
//  Delphos
//
//  Created by lingaadm on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

class PushNotificationDelegate: BaseDelegate {

    func registerDevice(){
        let objDeviceBean = DeviceBean()
        objDeviceBean.device_name = UIDevice.currentDevice().name
        print("Device Name =" + objDeviceBean.device_name!)
        objDeviceBean.token = gStrDeviceToken
        objDeviceBean.device_type = "ios"
        
        doPostAPIs.doRegisterDevice(objDeviceBean, callBack:{(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                print("Successfully registered")
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
}