//
//  ClaimsDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

class ClaimsDelegate: BaseDelegate {
    
    func showClaimApprovalPendingUI(_ objCurrentContoller: UIViewController){
        (objCurrentContoller as! EventShowController).cancelClaim.isHidden = false
        (objCurrentContoller as! EventShowController).claim.isHidden = false
        (objCurrentContoller as! EventShowController).claim.setTitle( "Claimed Pending Approval ", for: UIControlState())
        
        (objCurrentContoller as! EventShowController).claim.isEnabled = false
        (objCurrentContoller as! EventShowController).claim.backgroundColor = UIColor.gray
    }

    
    
    func showClaimAllList(_ objCurrentContoller: BaseController) {
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
                                       self.showClaimApprovalPendingUI(objCurrentContoller)
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
                                        self.showClaimApprovalPendingUI(objCurrentContoller)
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
    func showClaimListDetails(_ objCurrentContoller: BaseController) {
        var strClaimDetailId:String  = String(gClaimDetailId)
        
        doGetAPIs.getClaimListDetails(strClaimDetailId,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
                let objEventShowController = objCurrentContoller as! EventShowController
                
                DispatchQueue.main.async(execute: {
                   // gClaimsList = result as! ClaimListBean

                    gClaimsListDetails = result as! ClaimListClaimBeanBean
                    //self.isCheckNilOrNotBase(gClaimsListDetails.business,labelText: objEventShowController.labelBusiness)
                    
                    
                    if(gClaimsListDetails != nil){
                        
                        objEventShowController.labelBusiness.text! = self.ifNilReturnEmptyString(gClaimsListDetails.business)
                   
                       objEventShowController.labelJobTitle.text! =  self.ifNilReturnEmptyString(gClaimsListDetails.job_title)
                        
                        objEventShowController.labelUserName.text! = self.ifNilReturnEmptyString(gClaimsListDetails.user_name)
                 
                       
                        if(gClaimsListDetails.claim_id != nil){

                            objEventShowController.selectedClaimId = gClaimsListDetails.claim_id
                        }
                        if(gClaimsListDetails.event_id != nil){

                            objEventShowController.selectedEventId = gClaimsListDetails.event_id
                        }
                        
                        objEventShowController.mainLabelJobTitle.isHidden = false
                        objEventShowController.mainLabelBusiness.isHidden = false
                        objEventShowController.labelUserName.isHidden = false
                        objEventShowController.labelBusiness.isHidden = false
                        objEventShowController.labelJobTitle.isHidden = false
                    }
                    
                   // (objCurrentContoller as! EventShowController).claimBeanDetail = gclaimsListDetails
                    // (objCurrentContoller as! EventShowController).tableView.reloadData()
                  
                    
                })
            }
            else{
                self.showAlert(objCurrentContoller, strMessage: "Error in Claim List")
            }
        })
        
        
    }
    func claimAccept(_ objCurrentContoller: BaseController)  {
        
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
               (objCurrentContoller as! EventShowController).btnLinkSpeaker.setTitle( gEventAcceptBean.event.speaker, for: UIControlState())
                 (objCurrentContoller as! EventShowController).btnLinkLocation.setTitle(gEventAcceptBean.event.loc_name, for: UIControlState())
                (objCurrentContoller as! EventShowController).btnLinkCreatedBy.setTitle(gEventAcceptBean.event.user_name, for: UIControlState())
                    (objCurrentContoller as! EventShowController).tableView.isHidden = true
                })
               
            }
            else{
                // print("Error in Accept Claim")
                self.showAlert(objCurrentContoller, strMessage: "claim failure")
                (objCurrentContoller as! EventShowController).activityIndicator.stopAnimating()
                (objCurrentContoller as! EventShowController).overlayView.isHidden = true
                logger.log(LoggingLevel.INFO, message: "Error in Accept Claim")
                
            }
        })
        
        
    }
    func claimReject(_ objCurrentContoller: BaseController)  {
        
        var strClaimid:String  = String((objCurrentContoller as! EventShowController).selectedClaimId)
        //var strClaimEventId:String = String((objCurrentContoller as! EventShowController).selectedEventId)
        
        doPostAPIs.doRejectClaim(strClaimid,callBack: {(result: AnyObject,statusCode: Int)   in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if(statusCode == SUCCESS) {
               
                logger.log(LoggingLevel.INFO, message: "Claim Rejected")
                self.showAlert(objCurrentContoller, strMessage: "Claim Rejected")

                DispatchQueue.main.async(execute: {
                    
                    gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
                     
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: true)
                     //(objCurrentContoller as! EventShowController).tableView.reloadData()
                    //(objCurrentContoller as! EventShowController).tableView.hidden = false
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
    
    func claimEvent(_ objCurrentContoller: BaseController) -> Bool {
        
      
        //DOA calls
        doPostAPIs.doClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if (statusCode == SUCCESS){
                logger.log(LoggingLevel.INFO, message: "claimed")
               
                self.showAlert(objCurrentContoller, strMessage: "Event Claimed")
                DispatchQueue.main.async(execute: {
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
                
            }
            else {
                logger.log(LoggingLevel.INFO, message: "Event is not claimed")
                 self.showAlert(objCurrentContoller, strMessage: "Event is Not Claim")
                DispatchQueue.main.async(execute: {
                    
                    gObjEventShowController = self.fetchNavController(gStrEventShowControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjEventShowController, close: true)
                    
                })

            }
        }
        return true
    }
    func sendMessage(_ objCurrentContoller: BaseController)  {
        
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
                logger.log(LoggingLevel.INFO, message: "SEND MESSAGE")
                 self.showAlert(objCurrentContoller, strMessage: "Message Sent")
                DispatchQueue.main.async(execute: {
                    
                    gObjMessageController = self.fetchNavController(gStrMessageControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjMessageController, close: true)
                })


                
            } else {
                logger.log(LoggingLevel.INFO, message: "NOT SEND MESSAGE")
                self.showAlert(objCurrentContoller, strMessage: "NOT SEND MESSAGE")
                DispatchQueue.main.async(execute: {
                    
                    gObjMessageController = self.fetchNavController(gStrMessageControllerID)
                    
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjMessageController, close: true)
                })

                
            }
        }
        
    }
    
    func messageClick(_ objCurrentContoller: UIViewController){
        logger.log(LoggingLevel.INFO, message: "Send Message")
        

        
       // if(gObjMessageController == nil){
            gObjMessageController = self.fetchNavController(gStrMessageControllerID)
        //}
        doNavigate(objCurrentContoller, toController: gObjMessageController, close: true)
        
        //        objCurrentContoller.slideMenuController()?.changeMainViewController(gObjMessageController, close: false)
        //    
    }

    func cancelClaim(_ objCurrentContoller: BaseController) -> Bool {
        
        //   var claimID = gObjShowEventBean.claim_id
        
        doPostAPIs.doCancelClaim(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            self.doCleanup(statusCode, objCurrentController:objCurrentContoller)
            if (statusCode == SUCCESS){
                logger.log(LoggingLevel.INFO, message: "Cancel claimed")
                //if(gObjHomeController == nil){
                self.showAlert(objCurrentContoller, strMessage: "Claim Canceled")
                DispatchQueue.main.async(execute: {
                
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
                               //}
                    objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
            } else {
                logger.log(LoggingLevel.INFO, message: "not claimed")
                
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
