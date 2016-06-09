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
    
    func showAlert(objCurrentController: UIViewController, strMessage: String) {
        dispatch_async(dispatch_get_main_queue(), {
            let alertView = UIAlertController(title: "Error", message: strMessage, preferredStyle: .Alert)
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
    
    func doNavigate(objCurrentController: UIViewController,toController: UINavigationController, close: Bool)->Void{
        
        objCurrentController.slideMenuController()?.changeMainViewController(toController, close: close)
    }

    func showEventUI(objCurrentContoller: UIViewController) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            
            if(gObjEventShowController == nil){
                gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
            }
            
            objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: false)
        })
    }
    
}
