//
//  ClaimsDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class ClaimsDelegate: BaseDelegate {
    func showClaimView(objCurrentContoller: UIViewController) {
        //var strClaimEventId: String = String(gObjShowEventBean.id)
        
        doGetAPIs.getClaimView(String(gObjShowEventBean.id),callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                dispatch_async(dispatch_get_main_queue(), {
                    var claimsList = result as! ClaimListBean
                    (objCurrentContoller as! EventShowController).claimBeanArray = claimsList.claims
                    (objCurrentContoller as! EventShowController).tableView.reloadData()
                })
            }
        })
    }
    func showClaimListDetails(objCurrentContoller: UIViewController) {
        var strClaimDetailId:String  = String(gClaimDetailId)
        
        doGetAPIs.getClaimListDetails(strClaimDetailId,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                var objEventShowController = objCurrentContoller as! EventShowController
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    var  claimsListDetails = result as! ClaimListClaimBeanBean
                    objEventShowController.labelBusiness.text! = String(claimsListDetails.business)
                    objEventShowController.labelJobTitle.text! = String(claimsListDetails.job_title)
                    objEventShowController.labelUserName.text! = String(claimsListDetails.user_name)
                    objEventShowController.selectedClaimId = claimsListDetails.claim_id
                    objEventShowController.selectedEventId = claimsListDetails.event_id
                    
                    
                    // (objCurrentContoller as! EventShowController).claimBeanDetail = gclaimsListDetails
                    // (objCurrentContoller as! EventShowController).tableView.reloadData()
                    
                    
                })
            }
            else{
                self.showAlert(objCurrentContoller, strMessage: "Error in Claim List")
            }
        })
        
        
    }
    func claimAccept(objCurrentContoller: UIViewController)  {
        
        var strClaimid:String  = String((objCurrentContoller as! EventShowController).selectedClaimId)
        var strClaimEventId:String = String((objCurrentContoller as! EventShowController).selectedEventId)
        
        doPostAPIs.doAcceptClaim(strClaimEventId,strClaimid: strClaimid,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                // var objEventShowController = objCurrentContoller as! EventShowController
                
            }
            else{
                // print("Error in Accept Claim")
                self.showAlert(objCurrentContoller, strMessage: "Error in Accept Claim")
            }
        })
        
        
    }
    func claimReject(objCurrentContoller: UIViewController)  {
        
        var strClaimid:String  = String((objCurrentContoller as! EventShowController).selectedClaimId)
        //var strClaimEventId:String = String((objCurrentContoller as! EventShowController).selectedEventId)
        
        doPostAPIs.doRejectClaim(strClaimid,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                // var objEventShowController = objCurrentContoller as! EventShowController
                
            }
            else{
                // print("Error in Accept Claim")
                self.showAlert(objCurrentContoller, strMessage: "Error in Reject Claim")
            }
        })
        
        
    }
    
    func claimEvent(objCurrentContoller: UIViewController) -> Bool {
        
        //  var objShowEventBean: ShowEventBean = ShowEventBean()
        
        // objClaimBean.user_id = gObjUsers.id
        // objClaimBean.event_id = gObjShowEventBean.user_id
        //DOA calls
        doPostAPIs.doClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            
            if (statusCode == SUCCESS){
                print("claimed")
                if(gObjHomeController == nil){
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                }
                objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                
                //                let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("HomeID") as! HomeController
                //                objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                
            } else {
                print("not claimed")
            }
        }
        return true
    }
    
    func cancelClaim(objCurrentContoller: UIViewController) -> Bool {
        
        //   var claimID = gObjShowEventBean.claim_id
        
        doPostAPIs.doCancelClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            if (statusCode == SUCCESS){
                print("Cancel claimed")
            } else {
                print("not claimed")
            }
        }
        
        return true
    }

}
