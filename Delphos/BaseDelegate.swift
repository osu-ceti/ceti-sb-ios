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
    
    func showAlert(_ objCurrentController: UIViewController, strMessage: String) {
        
        DispatchQueue.main.async(execute: {
            let alertView = UIAlertController(title: DelphosStrings.EMPTY_STRING, message: strMessage, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            objCurrentController.present(alertView, animated: true, completion: nil)
             
            
        })
    }
    
    func instantiateVC(_ controllerId: String) -> UIViewController{
        return  gObjStoryBoard.instantiateViewController(withIdentifier: controllerId)
        
    }
    
    func fetchNavController(_ controllerId: String) -> UINavigationController{
        return UINavigationController( rootViewController: instantiateVC(controllerId))
    }
    
    func getNavigationController(_ objController: UIViewController) -> UINavigationController{
        return UINavigationController( rootViewController: objController)
    }
    
    
    func doNavigate(_ objCurrentController: UIViewController,toController: UINavigationController, close: Bool)->Void{
        
        DispatchQueue.main.async(execute: {
            objCurrentController.slideMenuController()?.changeMainViewController(toController, close: close)
        })
    }

    func showEventUI(_ objCurrentContoller: UIViewController) {
        
        DispatchQueue.main.async(execute: {
            
            
            //if(gObjEventShowController == nil){
                gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
            //}
            
            objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: false)
        })
    }
    
    func showEvent(_ objCurrentContoller: BaseController) {
        var strUserDetail: String = String(gEventID)
        
        doGetAPIs.getEvent(strUserDetail,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                gObjShowEventBean = result as! ShowEventBean
                self.showEventUI(objCurrentContoller)
                
            }
        })
    }
    
    func showAwardBadge(_ event_name: String,
                        event_id: Int, speaker_name: String, badge_url: String) {
       
       
        
        let objBadgesController = self.instantiateVC(gStrBadgeControllerID) as! BadgeController
        
        objBadgesController.txtEventName = event_name
        objBadgesController.eventId = event_id
        objBadgesController.txtSpeakerName = speaker_name
        objBadgesController.badgeUrl = badge_url
        
        gObjBadgeControllerNav = self.getNavigationController(objBadgesController)
        
        
        rootViewController.slideMenuController()?.changeMainViewController(gObjBadgeControllerNav, close: true)

    
    }
    
    func RedirectLoginPage(_ objCurrentContoller: UIViewController){
        
        //var loginController = objCurrentContoller as! LoginController
        DispatchQueue.main.async(execute: {
            
            gObjLoginController = self.fetchNavController(gStrLoginControllerID)
            
            objCurrentContoller.slideMenuController()?.changeMainViewController(gObjLoginController, close: true)
        })
    }
    
    func removeUserCodes(){
        userCredsStorage.removeObject(forKey: gStrUserStorageKey)
        userCredsStorage.removeObject(forKey: gStrUserStoragePassKey)
    }
    
    func responseCodeErrorHandler(_ statusCode: Int, objCurrentController:BaseController){
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
    
    func doCleanup(_ statusCode: Int, objCurrentController: BaseController){
        DispatchQueue.main.async(execute: {
            objCurrentController.hideOverlayView()
        })
        responseCodeErrorHandler(statusCode, objCurrentController: objCurrentController)
    }
    
    func ifNilReturnEmptyString(_ labelData: String?) -> String{
        
        if(labelData != nil){
            return labelData!
        }
        else{
            return DelphosStrings.EMPTY_STRING
        }
       
    }
    func ifNilReturnEmptyInt(_ labelData: Int?) -> Int{
        
        if(labelData != nil){
            return labelData!
        }
        else{
            return DelphosStrings.EMPTY_INT
        }
        
    }
    
}
