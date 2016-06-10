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
                    
                    //                    let goToSearchController = objCurrentController.storyboard?.instantiateViewControllerWithIdentifier("searchID") as! SearchController
                    
                    //if(gObjSearchController == nil){
                        gObjSearchController = self.instantiateVC(gStrSearchControllerID) as! SearchController
                    //}
                    
                    
                    if(gBtnRadioValue == "events") {
                        gObjEventDisplayBean = result as! EventDisplayBean
                        gObjSearchController.eventBeanArray = gObjEventDisplayBean.events
                    }
                    else if(gBtnRadioValue == "schools") {
                        gObjUsersBean = result as! usersBean
                        gObjSearchController.schoolBeanArray = gObjUsersBean.users
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
                    if(gBtnRadioValue == events) {
                        gObjShowEventBean = result as! ShowEventBean
                    } else if(gBtnRadioValue == schools) {
                        
                    } else if(gBtnRadioValue == users) {
                        var objUserBean = result as! usersBean
                        gObjSearchUserListBean = objUserBean.user
                    }
                    self.showEventUI(objCurrentContoller)
                    //                    objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                })
            }
        })
        
    }

}