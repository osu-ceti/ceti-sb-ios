//
//  SchoolDelegate.swift
//  Delphos
//
//  Created by Babu on 6/18/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation

import UIKit


class SchoolDelegate:BaseDelegate{

    func schoolProfile(objCurrentContoller: UIViewController) {
        
      
            var strSchoolId: String
        if (gSchoolNameSelect == true)
        {
              strSchoolId = String(gObjSearchUserListBean.school_id)
        }
        else{
            strSchoolId = String(gObjUserBean.school_id)
        }

        doGetAPIs.getSchoolProfile(strSchoolId,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                gObjSchoolProfileController = self.instantiateVC(gStrSchoolProfileControllerID) as! SchoolProfileController
                
                
                var objSchoolBean = result as! SchoolsBean
                
                gObjSchoolProfileController.eventBeanArray = objSchoolBean.events
                gObjSearchSchoolListBean = objSchoolBean.school
                gObjSchoolImage = objSchoolBean.badge_url
               // gObjSchoolProfileController .schoolImage.image = UIImage(named:"objSchoolBean.badge_url")
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    var objSchoolProfileControllerNav = self.getNavigationController(gObjSchoolProfileController)
                    //}
                    
                    self.doNavigate(objCurrentContoller, toController: objSchoolProfileControllerNav,  close: true)
                })
                
            }
        })
    }
    func showMakeMySchool(objCurrentContoller: UIViewController) {
       
        var strSchoolId: String = String(gObjUserBean.school_id)
        
        //var strschool:String = {}
        
        doGetAPIs.getMakeMySchool(strSchoolId,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
             
                 var objMakeMySchoolBean = result as! MakeMySchoolBean
               gObjMakeMySchoolListBean = objMakeMySchoolBean.profile
                print("Make my school")
                 gObjPublicProfileController = self.instantiateVC(gStrPublicProfileControllerID) as! PublicProfileController
                dispatch_async(dispatch_get_main_queue(), {
                    
                   // gObjPublicProfileController = self.fetchNavController(gStrPublicProfileControllerID)
                    
                  // objCurrentContoller.slideMenuController()?.changeMainViewController(gObjPublicProfileController, close: true)
                    
                    
                    var objPublicProfileControllerNav = self.getNavigationController(gObjPublicProfileController)
                    
                    
                    self.doNavigate(objCurrentContoller, toController: objPublicProfileControllerNav,  close: true)

                                  })

              
                
            }
        })
    }
    
}
