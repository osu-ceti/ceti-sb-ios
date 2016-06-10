//
//  ClaimsDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class ClaimsDelegate: BaseDelegate {
    func showClaimAllList(objCurrentContoller: UIViewController) {
        //var strClaimEventId: String = String(gObjShowEventBean.id)
        
        doGetAPIs.getClaimView(String(gObjShowEventBean.id),callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                dispatch_async(dispatch_get_main_queue(), {
                     gClaimsList = result as! ClaimListBean
                    (objCurrentContoller as! EventShowController).claimBeanArray = gClaimsList.claims
                    (objCurrentContoller as! EventShowController).tableView.reloadData()
                  
                    if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.SPEAKER){
                    
                        if (gObjUserBean.id == gObjShowEventBean.speaker_id)
                        {
                                (objCurrentContoller as! EventShowController).self.cancelClaim.hidden = false
                                (objCurrentContoller as! EventShowController).self.claim.hidden = true
                        }
                        else {
                            if(gObjShowEventBean.speaker_id != 0){
                                (objCurrentContoller as! EventShowController).cancelClaim.hidden = true
                                (objCurrentContoller as! EventShowController).claim.hidden = true
                            }
                            else{
                                var match:Bool = false
                                for claimUser in gClaimsList.claims{
                                    if(gObjUserBean.id == claimUser.user_id)
                                    {
                                        match = true
                                        (objCurrentContoller as! EventShowController).cancelClaim.hidden = false
                                        (objCurrentContoller as! EventShowController).claim.hidden = false
                                        (objCurrentContoller as! EventShowController).claim.setTitle( "Claim Pending", forState: .Normal)
                                        (objCurrentContoller as! EventShowController).claim.enabled = false
                                        (objCurrentContoller as! EventShowController).claim.backgroundColor = UIColor.grayColor()
                                    }
                                }
                                if( match == false){
                                
                                    //Did no apply
                                    (objCurrentContoller as! EventShowController).cancelClaim.hidden = true
                                    (objCurrentContoller as! EventShowController).claim.hidden = false
                                }
                            }
                        }
                    }
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
                   // gClaimsList = result as! ClaimListBean

                    gClaimsListDetails = result as! ClaimListClaimBeanBean
                    objEventShowController.labelBusiness.text! = String(gClaimsListDetails.business)
                    objEventShowController.labelJobTitle.text! = String(gClaimsListDetails.job_title)
                    objEventShowController.labelUserName.text! = String(gClaimsListDetails.user_name)
                    objEventShowController.selectedClaimId = gClaimsListDetails.claim_id
                    objEventShowController.selectedEventId = gClaimsListDetails.event_id
                    
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
                self.showAlert(objCurrentContoller, strMessage: "Accept")
                
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
                //if(gObjHomeController == nil){
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                //}
                objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                
                //                let goToEventShowController = objCurrentContoller.storyboard?.instantiateViewControllerWithIdentifier("HomeID") as! HomeController
                //                objCurrentContoller.presentViewController(goToEventShowController, animated: true, completion: nil)
                
            } else {
                print("not claimed")
                 self.showAlert(objCurrentContoller, strMessage: "Not Claim")
            }
        }
        return true
    }
    func sendMessage(objCurrentContoller: UIViewController)  {
        
        var strSendMessage:String = String((objCurrentContoller as! MessageController).txtSendMessage)
        var strUserId:String = String(gUserId)
        
        var objInputBean:SendMessageBean = SendMessageBean()
        
        objInputBean.id = Int(strUserId)
        objInputBean.user_message = strSendMessage
        //
        //        var objInputParamBean:ClaimSendMessageBean = ClaimSendMessageBean()
        //
        //        objInputParamBean.message = objInputBean
        doPostAPIs.doSendMessage(objInputBean){ (loginResult: AnyObject, statusCode: Int) in
            
            if (statusCode == 200){
                print("SEND MESSAGE")
                 self.showAlert(objCurrentContoller, strMessage: "Message Sent")
                
            } else {
                print("NOT SEND MESSAGE")
                self.showAlert(objCurrentContoller, strMessage: "NOT SEND MESSAGE")
                
            }
        }
        
    }
    
    func messageClick(objCurrentContoller: UIViewController){
        print("Send Message")
        
       // if(gObjMessageController == nil){
            gObjMessageController = self.fetchNavController(gStrMessageControllerID)
        //}
        doNavigate(objCurrentContoller, toController: gObjMessageController, close: true)
        
        //        objCurrentContoller.slideMenuController()?.changeMainViewController(gObjMessageController, close: false)
        //    
    }

    func cancelClaim(objCurrentContoller: UIViewController) -> Bool {
        
        //   var claimID = gObjShowEventBean.claim_id
        
        doPostAPIs.doCancelClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            if (statusCode == SUCCESS){
                print("Cancel claimed")
                //if(gObjHomeController == nil){
                gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                //}
                objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
            } else {
                print("not claimed")
                self.showAlert(objCurrentContoller, strMessage: "Not Claimed")
            }
        }
        
        return true
    }

}
