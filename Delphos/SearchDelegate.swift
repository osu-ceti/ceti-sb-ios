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
        
        print(objCurrentController)
        let objEventDisplayController = objCurrentController as! NavController
        
        var strSearchText = objEventDisplayController.searchBar.text
        
        doGetAPIs.searchEvent(gBtnRadioValue!, strSearchEvent: strSearchText!, callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    gObjSearchController = self.instantiateVC(gStrSearchControllerID) as! SearchController
                   
                    if(gBtnRadioValue == "events") {
                        gObjEventDisplayBean = result as! EventDisplayBean
                        gObjSearchController.eventBeanArray = gObjEventDisplayBean.events
                    }
                    else if(gBtnRadioValue == "schools") {
                       gObjSchoolListBean = result as! SchoolsDisplayBean
                        // gObjUsersBean = result as! usersBean
                        gObjSearchController.schoolsBeanArray = gObjSchoolListBean.schools
                    }
                    else if(gBtnRadioValue == "users") {
                        gObjUsersBean = result as! usersBean
                        gObjSearchController.usersBeanArray = gObjUsersBean.users
                    }
                    
                    objCurrentController.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: gObjSearchController), close: false)
                    
                    //      print(eventDisplayController.eventBeanArray);
                    //                     objCurrentController.presentViewController(goToSearchController, animated: true, completion: nil)
                    //objEventDisplayController.tableView.reloadData()
                    
                })
                
            }
        })
        
        
    }
    
    func showSearch(objCurrentContoller: UIViewController) {
        
        var strShowSearch: String = String(gSearchValue)
        
        doGetAPIs.getSearchEventsAndUsers(gBtnRadioValue, strsearchID: strShowSearch,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    //                    let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("eventShowID") as! EventShowController
                    
                    gObjUserProfileController = self.instantiateVC(gStrUserProfileControllerID) as! UserProfileController
                    if(gBtnRadioValue == events) {
                        gObjShowEventBean = result as! ShowEventBean
                         self.showEventUI(objCurrentContoller)
                    } else if(gBtnRadioValue == schools) {
                        //gObjSchoolBean = result as! SchoolsBean
                        gObjSchoolProfileController = self.instantiateVC(gStrSchoolProfileControllerID) as! SchoolProfileController
                        
                        
                        var objSchoolBean = result as! SchoolsBean
                        
                        gObjSchoolProfileController.eventBeanArray = objSchoolBean.events
                        gObjSearchSchoolListBean = objSchoolBean.school
                        gObjSchoolImage = objSchoolBean.badge_url
                        var objSchoolProfileControllerNav = self.getNavigationController(gObjSchoolProfileController)
                        
                        
                        self.doNavigate(objCurrentContoller, toController: objSchoolProfileControllerNav,  close: true)
                    } else if(gBtnRadioValue == users) {
                       
                        var objUserBean = result as! usersBean
                        
                        gObjUserProfileController.eventBeanArray = objUserBean.events
                        gObjSearchUserListBean = objUserBean.user
                        gObjUserProfileController.userProfileBadgesBean = objUserBean.badges
                        //gObjUserProfileController = self.fetchNavController(gStrUserProfileControllerID)
                        
                         //objCurrentContoller.slideMenuController()?.changeMainViewController(gObjUserProfileController, close: false)
                        
                        
                        var objUserProfileControllerNav = self.getNavigationController(gObjUserProfileController)
                        //}
                        
                        self.doNavigate(objCurrentContoller, toController: objUserProfileControllerNav,  close: true)

                    }
                    
                   
                    //                    objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                })
            }
        })
        
    }

}