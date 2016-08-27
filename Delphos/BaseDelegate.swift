//
//  BaseDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper
class BaseDelegate: NSObject {
    
    var doPostAPIs: DAOServices!
    var doGetAPIs: DAOServices!
    
    
    override init() {
        doPostAPIs = DAOServices()
        doGetAPIs = doPostAPIs
    }
    
    func showAlert(objCurrentController: UIViewController, strMessage: String) {
        
        dispatch_async(dispatch_get_main_queue(), {
            let alertView = UIAlertController(title: "", message: strMessage, preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            
            objCurrentController.presentViewController(alertView, animated: true, completion: nil)
             
            
        })
    }
    
    func instantiateVC(controllerId: String) -> UIViewController{
        return  gObjStoryBoard.instantiateViewControllerWithIdentifier(controllerId)
        
    }
    
    func fetchNavController(controllerId: String) -> UINavigationController{
        return UINavigationController( rootViewController: instantiateVC(controllerId))
    }
    
    func getNavigationController(objController: UIViewController) -> UINavigationController{
        return UINavigationController( rootViewController: objController)
    }
    
    
    func doNavigate(objCurrentController: UIViewController,toController: UINavigationController, close: Bool)->Void{
        
        dispatch_async(dispatch_get_main_queue(), {
            objCurrentController.slideMenuController()?.changeMainViewController(toController, close: close)
        })
    }

    func showEventUI(objCurrentContoller: UIViewController) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            
            //if(gObjEventShowController == nil){
                gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
            //}
            
            objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: false)
        })
    }
    
    func showEvent(objCurrentContoller: BaseController) {
        var strUserDetail: String = String(gEventID)
        
        doGetAPIs.getEvent(strUserDetail,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                gObjShowEventBean = result as! ShowEventBean
                self.showEventUI(objCurrentContoller)
                
            }
        })
    }
    
    func showAwardBadge(event_name: String,
                        event_id: Int, speaker_name: String, badge_url: String) {
       
       
        
        let objBadgesController = self.instantiateVC(gStrBadgeControllerID) as! BadgeController
        
        objBadgesController.txtEventName = event_name
        objBadgesController.eventId = event_id
        objBadgesController.txtSpeakerName = speaker_name
        objBadgesController.badgeUrl = badge_url
        
        gObjBadgeControllerNav = self.getNavigationController(objBadgesController)
        
        
        rootViewController.slideMenuController()?.changeMainViewController(gObjBadgeControllerNav, close: true)

    
    }
    
    func RedirectLoginPage(objCurrentContoller: UIViewController){
        
        //var loginController = objCurrentContoller as! LoginController
        dispatch_async(dispatch_get_main_queue(), {
            
            gObjLoginController = self.fetchNavController(gStrLoginControllerID)
            
            objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
        })
    }
    
    func removeUserCodes(){
        userCredsStorage.removeObjectForKey(gStrUserStorageKey)
        userCredsStorage.removeObjectForKey(gStrUserStoragePassKey)
    }
    
    func responseCodeErrorHandler(statusCode: Int, objCurrentController:BaseController){
        switch(statusCode){
            case UNAUTHORIZED_REQUEST:
            //Redirect to login
                logger.log(LoggingLevel.INFO,message: SESSION_LOST)
                removeUserCodes()
                showAlert(objCurrentController, strMessage: SESSION_LOST)
                RedirectLoginPage(objCurrentController)
            break
        default:
            //Do nothing
            break
        }
    }
    
    func doCleanup(statusCode: Int, objCurrentController:BaseController){
        dispatch_async(dispatch_get_main_queue(), {
            objCurrentController.hideOverlayView()
        })
        responseCodeErrorHandler(statusCode, objCurrentController: objCurrentController)
    }
    
}
