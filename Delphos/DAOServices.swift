//
//  DAOPostAPIs.swift
//  Delphos
//
//  Created by Prabhu on 5/7/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper


class DAOServices: DAOBase {
    
    var addAuthHeader = true
    //GET APIs - STARTS HERE
    
    func getAllEvents(_ callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        print("getAllEvents")
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                // println(jsonResult)
                var eventDisplayBean = Mapper<EventDisplayBean>().map(jsonResult)
                
                callBack?(eventDisplayBean!, statusCode )
                
                return
            }
            else {
                
                //println(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    
    func getClaimView(_ strClaimEventId: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("claim view")
        strURL = DEV_TARGET + CLAIMS_LIST + "/" + SHOWCLAIMSDATA + "?" + EVENT_ID + "=" + strClaimEventId
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //  logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<ClaimListBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    func getClaimListDetails(_ strClaimDetailId: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("claim view")
        strURL = DEV_TARGET + CLAIMS_LIST + "/" + strClaimDetailId
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //  logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<ClaimListClaimBeanBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    
    func getEvent(_ strEventID: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("getEvent")
        strURL =  DEV_TARGET + EVENT + strEventID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<ShowEventBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    
    func searchEvent(_ gObjSearchBean: SearchBean, strSearchEvent: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        let addSpaceOnString: String = strSearchEvent
        
        let strReplaceSearch = addSpaceOnString.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil)
        if(gObjSearchBean.isLocation == false){
            strURL =  DEV_TARGET + gBtnRadioValue! + SEARCH_EVENT + strReplaceSearch
        }
        else{
            strURL =  DEV_TARGET + gBtnRadioValue!
            strURL = strURL + "?zip=" + String(gObjSearchBean.zip) + "&radius=" + String(gObjSearchBean.radius)
            strURL = strURL + "&location=true"
        }
        var searchBean: AnyObject!
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            
            if(status) {
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                if(gBtnRadioValue == "events") {
                    searchBean = Mapper<EventDisplayBean>().map(jsonResult)
                }
                else if(gBtnRadioValue == "schools") {
                    searchBean = Mapper<SchoolsDisplayBean>().map(jsonResult)
                }
                else if(gBtnRadioValue == "users") {
                    searchBean = Mapper<usersBean>().map(jsonResult)
                }
                
                callBack?(searchBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
            
        })
        
    }
    
    
    
    func getSearchEventsAndUsers(_ gBtnRadioValue: String, strsearchID: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("getEvent")
        
        if(gBtnRadioValue == events) {
            strURL =  DEV_TARGET + EVENT + strsearchID
        } else if(gBtnRadioValue == schools) {
            strURL =  DEV_TARGET + SCHOOL + strsearchID
        } else if(gBtnRadioValue == users) {
            strURL =  DEV_TARGET + USERS + strsearchID
        }
        
        var responseBean : AnyObject!
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                if(gBtnRadioValue == events) {
                    responseBean = Mapper<ShowEventBean>().map(jsonResult)
                } else if(gBtnRadioValue == schools) {
                     responseBean = Mapper<SchoolsBean>().map(jsonResult)
                    
                } else if(gBtnRadioValue == users) {
                    responseBean = Mapper<usersBean>().map(jsonResult)
                }
                
                 callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    
    func getShareBadge(_ callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get share badge")
        var strUserProfileId = String(gSearchUserProfile)
       
        var strBadgeid = String(gBadgeid)
        strURL = DEV_TARGET + USERS + strUserProfileId + "/" + BADGES + "/" + strBadgeid
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var showBadgeBean = Mapper<UserProfileBadgesBean>().map(jsonResult)
                
                callBack?(showBadgeBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
  
    
    func getSettings(_ callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get Settings")
        
        
        
        strURL = DEV_TARGET + USERS +  SETTINGS
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let showSettingsBean = Mapper<ViewSettingsResponse>().map(jsonResult)
                
                callBack?(showSettingsBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }

    
    func getAwardBadgeDetails(_ eventid :String,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        //print("GET AWARD DEATAILS")
        var strEventId = eventid
       // api/users/award_badge?event_id=282
       
        strURL = DEV_TARGET + USERS +  AWARD_BADGES + "?" + EVENT_ID + "=" + strEventId
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                print(jsonResult)
                let showAwardBadgeResponse = Mapper<AwardBadgesResponse>().map(jsonResult)
                
                callBack?(showAwardBadgeResponse!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    
    //GET APIs -- ENDS HERE
    
    
    
    
    
    
    //POST APIs -- STARTS HERE
    
     func doLogin(_ objLoginParam: LoginBean,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        
        
        print("doLogin")
        strURL =  LOGIN_URL
        let JSONString = Mapper().toJSONString(objLoginParam, prettyPrint: true)
        print(JSONString)
        doPost(JSONString!, addAuthHeader: false,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                let userBean = Mapper<UserBean>().map(jsonResult)!
                callBack?(userBean, statusCode )
                return
            }
            else{
                //println(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
        })
     }
    func doRegister(_ objLoginParam: LoginBean,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        print("doRegister")
        strURL =  REGISTER_URL
        let JSONString = Mapper().toJSONString(objLoginParam, prettyPrint: true)
        
        doPost(JSONString!, addAuthHeader: false,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                var userBean = Mapper<RegistrationResponseBean>().map(jsonResult)!
                callBack?(userBean, statusCode )
                return
            }
            else{
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
        })
    }
    
    func doSaveEvent(_ isEdit: Bool, eventId: Int, objEventParam: Mappable,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        print("doCreateEvent")
        var method :String
        if(isEdit)
        {
            strURL = EVENT_URL + "/" + String(eventId)
            method = PATCH
        }
        else{
            strURL =  CREATE_EVENT_URL
            method = POST
        }
         var JSONString = ""
        if(isEdit){
            JSONString = Mapper().toJSONString(objEventParam as! CreateEventBean, prettyPrint: true)!
        }
        else{
            JSONString = Mapper().toJSONString(objEventParam as! CreateBean, prettyPrint: true)!

        }
        
        
        doUpdate(method,strInputParamsJson: JSONString, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                if(!isEdit){
                    for (key, value) in jsonResult {
                        print("\(key) = \(value)")
                        if(key as! String == "event"){
                            var result = (value as! String)
                            var slashesStrippedResult = result.replacingOccurrences(of: "\\\"", with: "\"")
                            var commasCorrectedResult = slashesStrippedResult.replacingOccurrences(of: ",", with: ",\n")
                            var finalResult = commasCorrectedResult.replacingOccurrences(of: "}", with: "\n}")
                            finalResult = commasCorrectedResult.replacingOccurrences(of: "{", with: "{\n")
                            print("finalResult")
                            print(finalResult)
                        
                            let responseBean = Mapper<CreateEventResultEventBean>().map(finalResult)!
                            if (responseBean.id != nil){
                                
                                
                                responseBean.event_start = self.prettyConvertDateString(responseBean.event_start)
                                responseBean.event_end = self.prettyConvertDateString(responseBean.event_end)
                                
                                
                                callBack?(responseBean, statusCode )
                            }
                            else{
                                //Return Error
                                print("Server responded  event_id=null")
                                var  errorBean = ErrorBean()
                                errorBean.statusCode = 400
                                errorBean.description = "Failed to Create Event"
                                callBack?(errorBean, errorBean.statusCode )
                            }
                            
                            return

                        }
                    }
                }
               
                else{
                    let responseBean = Mapper<CreateEventResultBean>().map(jsonResult)!
                    callBack?(responseBean.event, statusCode )
                    return
                }
               
            }
            else{
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
        })
    }

    
    func doClaim(_ objresponseBean: ShowEventBean,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("doClaim")
      // var event_id = String(gObjUsers.id)
       // var user_id = String(gObjresponseBean.user_id)
        strURL =  CREATE_CLAIMS
            //+ events + USER_CLAIM + String(objClaimBean.user_id)
         // strURL =  CREATE_CLAIMS + "?" + "event_id=" + event_id + "&" + "user_id=" + user_id
        let JSONString = Mapper().toJSONString(objresponseBean, prettyPrint: true)
        
        doPost(JSONString!, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
                callBack?(claimEventBean, statusCode )
                return
            }
            else{
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
        })
    }

    
    func doCancelClaim(_ objEventID: ShowEventBean,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        var strClaimID = String(objEventID.claim_id)
        strURL =  CLAIMS + String(objEventID.claim_id) + CANCEL_CLAIMS
        
     //   let JSONString = Mapper().toJSONString(strClaimID, prettyPrint: true)
        
        doDelete(strClaimID, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
          if(status) {
            var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
            callBack?(claimEventBean, statusCode )
            return
          } else {
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
            
            
        })
        
    }
    
    
    func doAcceptClaim(_ strClaimEventId : String ,strClaimid : String,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        var strEventId = String(strClaimEventId)
        var strClaimid = String(strClaimid)
        
        
        strURL =  CLAIMS_LIST + "/" + TEACHER_CONFIRM + "?event_id="
        strURL = strURL +
            strEventId! + "&claim_id=" + strClaimid!
        
        doPost(strEventId,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
              logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                 var acceptEventbean = Mapper<ClaimAcceptBean>().map(jsonResult)!
                 callBack?(acceptEventbean, statusCode )
                 return
            }
            else {
                //logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }

        
    })
    }
    func doSendMessage(_ objSendMessage : SendMessageBean,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        let JSONString = Mapper().toJSONString(objSendMessage, prettyPrint: true)

        
        var strUserId = String(objSendMessage.id)
        strURL =  SEND_MESSAGE + "/" + strUserId
        
        doPost(JSONString!,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
                callBack?(claimEventBean, statusCode )
                return
            }
            else {
                //println(jsonResult)
               var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
            
            
        })
    }
    
    func doRejectClaim(_ strClaimid:String,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
    
   
    var strClaimid = String(strClaimid)
    strURL =  CLAIMS_LIST + "/" + strClaimid! + "/"  + REJECT
    doDelete(strClaimid!,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
    
    if(status){
        var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
        callBack?(claimEventBean, statusCode )
        return
    }
    else {
        //println(jsonResult)
        var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
        callBack?(errorBean, statusCode )
        return
    }
    
    
    })
    }

    
    func doCancelEvent(_ objEventID: ShowEventBean,callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        var strEventID = String(objEventID.id)
        strURL =  EVENT + String(objEventID.id) + CANCEL_EVENT
        
        //   let JSONString = Mapper().toJSONString(strClaimID, prettyPrint: true)
        
        doDelete(strEventID, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            if(status) {
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var cancelEventBean = Mapper<CancelEventBean>().map(jsonResult)!
                callBack?( cancelEventBean, statusCode )
                return
            } else {
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
            
            
        })
        
   


}
    
    
    func getUserProfile(_ strUserID: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get user profile make my school")
        strURL =   DEV_TARGET + USERS + strUserID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<usersBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    
    func getSchoolProfile(_ strSchoolID: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get school profile")
        strURL =  DEV_TARGET + SCHOOL + strSchoolID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var showSchoolBean = Mapper<SchoolsBean>().map(jsonResult)
                
                callBack?(showSchoolBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }

    
    
    
    
    func doSignOut(_ callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        let strEmptyJson = gEmptyJSON
        strURL =   USERS + SIGN_OUT
       
        
        //let JSONString = Mapper().toJSONString(strClaimID:nil, prettyPrint: true)
        
        doDelete(strEmptyJson,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            if(status) {
                var signoutBean = Mapper<SignoutResponseBean>().map(jsonResult)!
               callBack?(signoutBean, statusCode )
                return
            } else {
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
            
            
        })
        
    }
    
    
    
    func getMakeMySchool(_ strSchoolID: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get male my school")
        strURL =  DEV_TARGET + SCHOOL + MAKE_MINE + strSchoolID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                
                let responseBean = Mapper<MakeMySchoolBean>().map(jsonResult)
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }

    func doEditProfile(_ objUserProfile: MakeMySchoolListBean, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("PUT USER PROFILE")
        strURL =  USER_PROFILE
       
        let userJSONString = Mapper().toJSONString(objUserProfile, prettyPrint: true)
        doPut(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<EditUserProfileBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    func getMenuUserProfile(_ callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get user profile")
        strURL =   DEV_TARGET + USERS + PROFILE
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<UserBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
   
    func getAwardbadges(_ strSchoolID: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get award badges")
        strURL =  DEV_TARGET + USERS + AWARD_BADGES
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<SchoolsBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    func getNotification(_ pageValue: String, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("get Notification")
        if(pageValue == "1"){
           
            strURL =   DEV_TARGET + NOTIFICATION

        }
        else{
             strURL =   DEV_TARGET + NOTIFICATION + "?page=" + pageValue
        }
        
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let showNotificationBean = Mapper<NotificationBean>().map(jsonResult)
                
                callBack?(showNotificationBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }
    func doDeleteNotification(_ callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        let strEmptyJson = gEmptyJSON
        strURL =   NOTIFICATION
        
        
        //let JSONString = Mapper().toJSONString(strClaimID:nil, prettyPrint: true)
        
        doDelete(strEmptyJson,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status) {
                let signoutBean = Mapper<SignoutResponseBean>().map(jsonResult)!
                callBack?(signoutBean, statusCode )
                return
            } else {
                //println(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
            
            
        })
        
    }
    func postBadgesAward(_ badgesAwardToEvent:Bool, eventId:Int, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        let strAward:String
        if(badgesAwardToEvent)
        {
            strAward = "true"
        }
        else{
            strAward = "false"
        }
        
        //let strAward = String(badgesAwardToEvent)
        let strEventId = String(eventId)
        
        
        let strSubUrl = "?award=" + strAward
        
        let strSubUrl2 = "&event_id=" + strEventId
        
        strURL = USERS + AWARD_BADGES + strSubUrl + strSubUrl2
        
        
        
        //var JSONString = Mapper().toJSONString(objAwardBadges, prettyPrint: true)
        
        doPost(nil,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                print(jsonResult)
                let awardBadgeResponseBean = Mapper<AwardBadgeResponse>().map(jsonResult)!
                callBack?(awardBadgeResponseBean, statusCode )
                return
            }
            else {
                //println(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(errorBean, statusCode )
                return
            }
            
            
        })
    }
    
    func doRegisterDevice(_ objDeviceBean: DeviceBean, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        strURL = REGISTER_DEVICE
        let userJSONString = Mapper().toJSONString(objDeviceBean, prettyPrint: true)
        doPost(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<DeviceBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
        
    }
    func doReadNotification(_ strId: String , callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        
        strURL = NOTIFICATION + "/" + strId
            
        doPost(gEmptyJSON, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<DeviceBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
        
    }

    func doSaveSettings(_ objSaveSetting: SettingsBean, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("save setting PROFILE")
        strURL = USERS + SETTINGS
        
        let userJSONString = Mapper().toJSONString(objSaveSetting, prettyPrint: true)
        doPut(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<EditUserProfileBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }

    func doEditProfileAccount(_ objEditAccount: AccountEditListBean, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("PUT EDIT ACCOUNT PROFILE")
        strURL =  ACCOUNT
        
        let userJSONString = Mapper().toJSONString(objEditAccount, prettyPrint: true)
        doPut(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            
            //logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let showAccountEditBean = Mapper<AccountEditResponseBean>().map(jsonResult)
                
                callBack?(showAccountEditBean!, statusCode )

                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }

    
    func doResetPassword(_ objResetPassword: ResetPasswordBean, callBack: ((_ result: AnyObject, _ statusCode: Int) -> Void)?) {
        print("Reset Password")
        strURL =   USERS + PASSWORD
        
        let userJSONString = Mapper().toJSONString(objResetPassword, prettyPrint: true)
        doPost(userJSONString!, addAuthHeader: false,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            logger.log(LoggingLevel.INFO, message: "\(jsonResult)");
            
            if(status) {
                //    logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                var responseBean = Mapper<EditUserProfileBean>().map(jsonResult)
                
                callBack?(responseBean!, statusCode )
                
                return
            }
            else {
                
                logger.log(LoggingLevel.INFO, message: "\(jsonResult)")
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(errorBean, statusCode )
                
                return
                
                
            }
        })
    }

}
