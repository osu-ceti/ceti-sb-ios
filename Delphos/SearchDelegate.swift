//
//  SearchDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class SearchDelegate: BaseDelegate {
    func  searchEvent(objCurrentController: UIViewController) {
        
//        print(objCurrentController)
        let objEventDisplayController = objCurrentController as! NavController
        
        var strSearchText = objEventDisplayController.searchBar.text
        
        doGetAPIs.searchEvent(gBtnRadioValue!, strSearchEvent: strSearchText!, callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objEventDisplayController)
            if(statusCode == SUCCESS) {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    gObjSearchController = self.instantiateVC(gStrSearchControllerID) as! SearchController
                   
                    if(gBtnRadioValue == "events") {
                        gObjEventDisplayBean = result as! EventDisplayBean
                        if(gObjEventDisplayBean.events != nil){
                            gObjSearchController.eventBeanArray = gObjEventDisplayBean.events
                        }
                    }
                    else if(gBtnRadioValue == "schools") {
                       gObjSchoolListBean = result as! SchoolsDisplayBean
                        // gObjUsersBean = result as! usersBean
                        if(gObjSchoolListBean.schools != nil){
                            gObjSearchController.schoolsBeanArray = gObjSchoolListBean.schools
                        }
                    }
                    else if(gBtnRadioValue == "users") {
                        gObjUsersBean = result as! usersBean
                        if(gObjUsersBean.users != nil){
                            gObjSearchController.usersBeanArray = gObjUsersBean.users
                        }
                    }
                    
//                    if((gObjSearchController.eventBeanArray.count == 0) && (gObjSearchController.schoolsBeanArray.count == 0) && (gObjSearchController.usersBeanArray.count == 0)  ){
//                        print("test")
//                    
//                    }else{
                   
                    gObjSearchNavController = UINavigationController(rootViewController: gObjSearchController)
                    gObjBackTocontroller = gObjSearchNavController
                    
                    objCurrentController.slideMenuController()?.changeMainViewController(gObjSearchNavController, close: false)
                   // }
                    
                })
                
            }
        })
        
        
    }
    
    func showSearch(objCurrentContoller: BaseController) {
        
        var strShowSearch: String = String(gSearchValue)
        
        doGetAPIs.getSearchEventsAndUsers(gBtnRadioValue, strsearchID: strShowSearch,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    //                    let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("eventShowID") as! EventShowController
                    (objCurrentContoller as! SearchController).activityIndicator.stopAnimating()
                    (objCurrentContoller as! SearchController).overlayView.hidden = true
                    
                    
                    gObjUserProfileController = self.instantiateVC(gStrUserProfileControllerID) as! UserProfileController
                    
                    if(gBtnRadioValue == events) {
                        
                        gObjShowEventBean = result as! ShowEventBean
                        self.showEventUI(objCurrentContoller)
                    }
                    else if(gBtnRadioValue == schools) {
                        
                        //gObjSchoolBean = result as! SchoolsBean
                        gObjSchoolProfileController = self.instantiateVC(gStrSchoolProfileControllerID) as! SchoolProfileController
                        
                        
                        let objSchoolBean = result as! SchoolsBean
                        
                        if(objSchoolBean.events != nil){
                            gObjSchoolProfileController.eventBeanArray = objSchoolBean.events
                        }
                        if(objSchoolBean.school != nil){
                            gObjSearchSchoolListBean = objSchoolBean.school
                        }
                        if(objSchoolBean.badge_url != nil){
                            gObjSchoolImage = objSchoolBean.badge_url
                        }
                         gObjSchoolProfileNavController = self.getNavigationController(gObjSchoolProfileController)
                        
                        
                        self.doNavigate(objCurrentContoller, toController: gObjSchoolProfileNavController,  close: true)
                        
                    }
                    else if(gBtnRadioValue == users) {
                       
                        var objUserBean = result as! usersBean
                        
                        gObjUserProfileController.eventBeanArray = objUserBean.events
                        gObjSearchUserListBean = objUserBean.user
                        gObjUserProfileController.userProfileBadgesArray = objUserBean.badges
                        //gObjUserProfileController = self.fetchNavController(gStrUserProfileControllerID)
                        
                         //objCurrentContoller.slideMenuController()?.changeMainViewController(gObjUserProfileController, close: false)
                        
                        
                        gObjUserProfileNavController = self.getNavigationController(gObjUserProfileController)
                        //}
                        
                        self.doNavigate(objCurrentContoller, toController: gObjUserProfileNavController,  close: true)

                    }
                    
                   
                    //                    objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                })
            }
        })
        
    }

}