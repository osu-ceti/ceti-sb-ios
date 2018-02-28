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

    func schoolProfile(_ objCurrentContoller: BaseController) {
        
      
        var strSchoolId: String
        strSchoolId = String(gSchoolId)
        
        doGetAPIs.getSchoolProfile(strSchoolId,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                gObjSchoolProfileController = self.instantiateVC(gStrSchoolProfileControllerID) as! SchoolProfileController
                
                
                let objSchoolBean = result as! SchoolsBean
                
                gObjSchoolProfileController.eventBeanArray = objSchoolBean.events
                gObjSearchSchoolListBean = objSchoolBean.school
                gObjSchoolImage = String(objSchoolBean.badge_id) + "/" + objSchoolBean.badge_url
               
                
                DispatchQueue.main.async(execute: {
                    
                    gObjSchoolProfileNavController = self.getNavigationController(gObjSchoolProfileController)
                    self.doNavigate(objCurrentContoller, toController: gObjSchoolProfileNavController,  close: true)
                })
                
            }
        })
    }
    func showMakeMySchool(_ objCurrentContoller: BaseController) {
       
        let strSchoolId = (objCurrentContoller as! SchoolProfileController).strSchoolId
        let makeMySchoolName = (objCurrentContoller as! SchoolProfileController).makeMySchoolName
        
        //var strschool:String = {}
        
        doGetAPIs.getMakeMySchool(strSchoolId!,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
               
             
                 let objMakeMySchoolBean = result as! MakeMySchoolBean
                if(objMakeMySchoolBean.profile != nil){
                    gObjMakeMySchoolListBean = objMakeMySchoolBean.profile
                }
                if(gObjMakeMySchoolListBean.school_id != nil){

                    gObjUserBean.school_id = gObjMakeMySchoolListBean.school_id
                }
                if(makeMySchoolName != nil){
                    gObjUserBean.school_name = makeMySchoolName
                }
               // userProfileBean.school_id = gObjMakeMySchoolListBean.school_id
               
                logger.log(LoggingLevel.INFO, message: "Make my school")
               
                gObjPublicProfileController = self.instantiateVC(gStrPublicProfileControllerID) as! PublicProfileController
                DispatchQueue.main.async(execute: {

                    
                    let objPublicProfileControllerNav = self.getNavigationController(gObjPublicProfileController)
                    
                    
                    self.doNavigate(objCurrentContoller, toController: objPublicProfileControllerNav,  close: true)

                 })

              
                
            }
        })
    }
    
}
