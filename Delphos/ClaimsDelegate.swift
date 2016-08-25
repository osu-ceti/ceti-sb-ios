//
//  ClaimsDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class ClaimsDelegate: BaseDelegate {
    
    func showClaimApprovalPendingUI(objCurrentContoller: UIViewController){
        (objCurrentContoller as! EventShowController).cancelClaim.isHidden = false
        (objCurrentContoller as! EventShowController).claim.isHidden = false
        (objCurrentContoller as! EventShowController).claim.setTitle( "Claimed Pending Approval ", for: .normal)
        
        (objCurrentContoller as! EventShowController).claim.isEnabled = false
        (objCurrentContoller as! EventShowController).claim.backgroundColor = UIColor.gray
    }

    
    
    func showClaimAllList(objCurrentContoller: BaseController) {
        //var strClaimEventId: String = String(gObjShowEventBean.id)
        
        
        
        doGetAPIs.getClaimView(String(gObjShowEventBean.id),callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                
                DispatchQueue.main.async(execute: {
                    
                    gClaimsList = result as! ClaimListBean
                    (objCurrentContoller as! EventShowController).claimBeanArray = gClaimsList.claims
                  
                    var countClaimList = (objCurrentContoller as! EventShowController).claimBeanArray?.count
                    
                    (objCurrentContoller as! EventShowController).tableView.reloadData()
                    
                    var startDate = Date()
                    var currentDate = Date()
                    
                    startDate = (objCurrentContoller as! EventShowController).startDateAndTime
                    currentDate = (objCurrentContoller as! EventShowController).currentDate
                    
                   if (startDate.timeIntervalSinceReferenceDate > currentDate.timeIntervalSinceReferenceDate){
                        
                        
                    
                    if(gObjShowEventBean.active == true && (RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.speaker ||
                    RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.both ||
                    RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.teacher)  ){
                    
                        if (gObjUserBean.id == gObjShowEventBean.speaker_id)
                        {
                            //Applied already
                                (objCurrentContoller as! EventShowController).self.cancelClaim.isHidden = false
                                (objCurrentContoller as! EventShowController).self.claim.isHidden = true
                            
                        }
                         else {
                            if(gObjShowEventBean.speaker_id != 0){
                                //Approved
                                (objCurrentContoller as! EventShowController).cancelClaim.isHidden = true
                                (objCurrentContoller as! EventShowController).claim.isHidden = true
                            }
                            else{
                                var match:Bool = false
                                
                                for claimUser in gClaimsList.claims{
                                    if(gObjUserBean.id == claimUser.user_id)
                                    {
                                        //Approval Pending
                                        match = true
                                       self.showClaimApprovalPendingUI(objCurrentContoller: objCurrentContoller)
                                    }
                                    
                                    
                                }
                                if(gObjUserBean.id != gObjShowEventBean.user_id){
                                    if( match == false && gObjShowEventBean.claim_id == 0){
                                   
                                        //Did not apply
                                        (objCurrentContoller as! EventShowController).cancelClaim.isHidden = true
                                        (objCurrentContoller as! EventShowController).claim.isHidden = false
                                    
                                    }
                                    else{
                                        //Rejected
                                        self.showClaimApprovalPendingUI(objCurrentContoller: objCurrentContoller)
                                    }
                                }
                            }
                        }
                    }
                    }
                })
            }
        })
    }
    func showClaimListDetails(objCurrentContoller: BaseController) {
        var strClaimDetailId:String  = String(gClaimDetailId)
        
        doGetAPIs.getClaimListDetails(strClaimDetailId,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                var objEventShowController = objCurrentContoller as! EventShowController
                
                DispatchQueue.main.async(execute: {
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
    func claimAccept(objCurrentContoller: BaseController)  {
        
        let strClaimid:String  = String((objCurrentContoller as! EventShowController).selectedClaimId)
        let strClaimEventId:String = String((objCurrentContoller as! EventShowController).selectedEventId)
        
        doPostAPIs.doAcceptClaim(strClaimEventId,strClaimid: strClaimid,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                
               self.showAlert(objCurrentContoller, strMessage: "Claim Accepted")
             
                DispatchQueue.main.async(execute: {
                gEventAcceptBean = result as! ClaimAcceptBean
                gObjShowEventBean.speaker_id = gEventAcceptBean.event.speaker_id
                gSpeakerId = gEventAcceptBean.event.speaker_id
                gObjShowEventBean.speaker = gEventAcceptBean.event.speaker
               (objCurrentContoller as! EventShowController).btnLinkSpeaker.setTitle( gEventAcceptBean.event.speaker, for: .normal)
                 (objCurrentContoller as! EventShowController).btnLinkLocation.setTitle(gEventAcceptBean.event.loc_name, for: .normal)
                (objCurrentContoller as! EventShowController).btnLinkCreatedBy.setTitle(gEventAcceptBean.event.user_name, for: .normal)
                    (objCurrentContoller as! EventShowController).tableView.isHidden = true
                })
               
            }
            else{
                // print("Error in Accept Claim")
                self.showAlert(objCurrentContoller, strMessage: "claim failure")
                (objCurrentContoller as! EventShowController).activityIndicator.stopAnimating()
                (objCurrentContoller as! EventShowController).overlayView.isHidden = true
                logger.log(LoggingLevel.info, message: "Error in Accept Claim")
                
            }
        })
        
        
    }
    func claimReject(objCurrentContoller: BaseController)  {
        
        var strClaimid:String  = String((objCurrentContoller as! EventShowController).selectedClaimId)
        //var strClaimEventId:String = String((objCurrentContoller as! EventShowController).selectedEventId)
        
        doPostAPIs.doRejectClaim(strClaimid,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
               
                logger.log(LoggingLevel.info, message: "Claim Rejected")
                self.showAlert(objCurrentContoller, strMessage: "Claim Rejected")

                DispatchQueue.main.async(execute: {
                    
                    gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
                     
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: true)
                     //(objCurrentContoller as! EventShowController).tableView.reloadData()
                    //(objCurrentContoller as! EventShowController).tableView.isHidden = false
                    })
            
            
            }
            else{
                // print("Error in Accept Claim")
                self.showAlert(objCurrentContoller, strMessage: "Claim Reject failure")

                DispatchQueue.main.async(execute: {
                    
                    gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: true)
                   
                })
            }
        })
        
        
    }
    
    func claimEvent(objCurrentContoller: BaseController) -> Bool {
        
      
        //DOA calls
        doPostAPIs.doClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if (statusCode == SUCCESS){
                logger.log(LoggingLevel.info, message: "claimed")
               
                self.showAlert(objCurrentContoller, strMessage: "Event Claimed")
                DispatchQueue.main.async(execute: {
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
                
            }
            else {
                logger.log(LoggingLevel.info, message: "Event is not claimed")
                 self.showAlert(objCurrentContoller, strMessage: "Event is Not Claim")
                DispatchQueue.main.async(execute: {
                    
                    gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: true)
                    
                })

            }
        }
        return true
    }
    func sendMessage(objCurrentContoller: BaseController)  {
        
        var strSendMessage:String = (objCurrentContoller as! MessageController).txtSendMessage.text!
        var strUserId:String!
        
        if( gUserProfileMessage == true){
        
                strUserId = String((objCurrentContoller as! MessageController).userMessageId)
        
        }
        else{
        
            if(RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.teacher ||
                RoleType(rawValue:UInt(gObjUserBean.role)) == RoleType.both){
                strUserId = String(gClaimUser_id)
            }
            else{
                strUserId = String(gObjShowEventBean.user_id)
            }
        }
        var objInputBean:SendMessageBean = SendMessageBean()
        
        objInputBean.id = Int(strUserId)
        objInputBean.user_message = strSendMessage
        //
        //        var objInputParamBean:ClaimSendMessageBean = ClaimSendMessageBean()
        //
        //        objInputParamBean.message = objInputBean
        doPostAPIs.doSendMessage(objInputBean){ (loginResult: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if (statusCode == SUCCESS){
                logger.log(LoggingLevel.info, message: "SEND MESSAGE")
                 self.showAlert(objCurrentContoller, strMessage: "Message Sent")
                DispatchQueue.main.async(execute: {
                    
                    gObjMessageController = self.fetchNavController(gStrMessageControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjMessageController, close: true)
                })


                
            } else {
                logger.log(LoggingLevel.info, message: "NOT SEND MESSAGE")
                self.showAlert(objCurrentContoller, strMessage: "NOT SEND MESSAGE")
                DispatchQueue.main.async(execute: {
                    
                    gObjMessageController = self.fetchNavController(gStrMessageControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjMessageController, close: true)
                })

                
            }
        }
        
    }
    
    func messageClick(objCurrentContoller: UIViewController){
        logger.log(LoggingLevel.info, message: "Send Message")
        

        
       // if(gObjMessageController == nil){
            gObjMessageController = self.fetchNavController(gStrMessageControllerID)
        //}
        doNavigate(objCurrentContoller, toController: gObjMessageController, close: true)
        
        //        objCurrentContoller.slideMenuController()?.changeMainViewController(gObjMessageController, close: false)
        //    
    }

    func cancelClaim(objCurrentContoller: BaseController) -> Bool {
        
        //   var claimID = gObjShowEventBean.claim_id
        
        doPostAPIs.doCancelClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if (statusCode == SUCCESS){
                logger.log(LoggingLevel.info, message: "Cancel claimed")
                //if(gObjHomeController == nil){
                self.showAlert(objCurrentContoller, strMessage: "Claim Canceled")
                DispatchQueue.main.async(execute: {
                
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                               //}
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
            } else {
                logger.log(LoggingLevel.info, message: "not claimed")
                
                self.showAlert(objCurrentContoller, strMessage: "Claim Not Cancel")
                DispatchQueue.main.async(execute: {
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
            
            }
        }
        
        return true
    }

}
