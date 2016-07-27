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
    
    func getAllEvents(callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        print("getAllEvents")
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                // println(jsonResult)
                var eventDisplayBean = Mapper<EventDisplayBean>().map(jsonResult)
                
                callBack?(result: eventDisplayBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                //println(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    
    func getClaimView(strClaimEventId: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("claim view")
        strURL = DEV_TARGET + CLAIMS_LIST + "/" + SHOWCLAIMSDATA + "?" + EVENT_ID + "=" + strClaimEventId
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //  print(jsonResult)
                var showEventBean = Mapper<ClaimListBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    func getClaimListDetails(strClaimDetailId: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("claim view")
        strURL = DEV_TARGET + CLAIMS_LIST + "/" + strClaimDetailId
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //  print(jsonResult)
                var showEventBean = Mapper<ClaimListClaimBeanBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    
    func getEvent(strEventID: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("getEvent")
        strURL =  DEV_TARGET + EVENT + strEventID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<ShowEventBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    
    func searchEvent(gBtnRadioValue: String, strSearchEvent: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        strURL =  DEV_TARGET + gBtnRadioValue + SEARCH_EVENT + strSearchEvent
        var searchBean: AnyObject!
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            
            if(status) {
                print(jsonResult)
                if(gBtnRadioValue == "events") {
                    searchBean = Mapper<EventDisplayBean>().map(jsonResult)
                }
                else if(gBtnRadioValue == "schools") {
                    searchBean = Mapper<SchoolsDisplayBean>().map(jsonResult)
                }
                else if(gBtnRadioValue == "users") {
                    searchBean = Mapper<usersBean>().map(jsonResult)
                }
                
                callBack?(result: searchBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
            
        })
        
    }
    
    
    
    func getSearchEventsAndUsers(gBtnRadioValue: String, strsearchID: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("getEvent")
        
        if(gBtnRadioValue == events) {
            strURL =  DEV_TARGET + EVENT + strsearchID
        } else if(gBtnRadioValue == schools) {
            strURL =  DEV_TARGET + SCHOOL + strsearchID
        } else if(gBtnRadioValue == users) {
            strURL =  DEV_TARGET + USERS + strsearchID
        }
        
        var showEventBean : AnyObject!
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                if(gBtnRadioValue == events) {
                    showEventBean = Mapper<ShowEventBean>().map(jsonResult)
                } else if(gBtnRadioValue == schools) {
                     showEventBean = Mapper<SchoolsBean>().map(jsonResult)
                    
                } else if(gBtnRadioValue == users) {
                    showEventBean = Mapper<usersBean>().map(jsonResult)
                }
                
                 callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    
    func getShareBadge(callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get share badge")
        var strUserProfileId = String(gSearchUserProfile)
       
        var strBadgeid = String(gBadgeid)
        strURL = DEV_TARGET + USERS + strUserProfileId + "/" + BADGES + "/" + strBadgeid
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showBadgeBean = Mapper<UserProfileBadgesBean>().map(jsonResult)
                
                callBack?(result: showBadgeBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
  
    
    func getSettings(callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get Settings")
        
        
        
        strURL = DEV_TARGET + USERS +  SETTINGS
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                let showSettingsBean = Mapper<ViewSettingsResponse>().map(jsonResult)
                
                callBack?(result: showSettingsBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }

    
    
    //GET APIs -- ENDS HERE
    
    
    
    
    
    
    //POST APIs -- STARTS HERE
    
     func doLogin(objLoginParam: LoginBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        
        
        print("doLogin")
        strURL =  LOGIN_URL
        let JSONString = Mapper().toJSONString(objLoginParam, prettyPrint: true)
        print(JSONString)
        doPost(JSONString!, addAuthHeader: false,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                var userBean = Mapper<UserBean>().map(jsonResult)!
                callBack?(result: userBean, statusCode: statusCode )
                return
            }
            else{
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
        })
     }
    func doRegister(objLoginParam: LoginBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        print("doRegister")
        strURL =  REGISTER_URL
        let JSONString = Mapper().toJSONString(objLoginParam, prettyPrint: true)
        
        doPost(JSONString!, addAuthHeader: false,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                var userBean = Mapper<usersBean>().map(jsonResult)!
                callBack?(result: userBean, statusCode: statusCode )
                return
            }
            else{
                print(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
        })
    }
    
    func doSaveEvent(isEdit: Bool, eventId: Int, objEventParam: Mappable,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
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
                            var slashesStrippedResult = result.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
                            var commasCorrectedResult = slashesStrippedResult.stringByReplacingOccurrencesOfString(",", withString: ",\n")
                            var finalResult = commasCorrectedResult.stringByReplacingOccurrencesOfString("}", withString: "\n}")
                            finalResult = commasCorrectedResult.stringByReplacingOccurrencesOfString("{", withString: "{\n")
                            print(finalResult)
                        
                            let showEventBean = Mapper<CreateEventResultEventBean>().map(finalResult)!
                            if (showEventBean.id != nil){
                                
                                
                                showEventBean.event_start = self.prettyConvertDateString(showEventBean.event_start)
                                showEventBean.event_end = self.prettyConvertDateString(showEventBean.event_end)
                                
                                
                                callBack?(result: showEventBean, statusCode: statusCode )
                            }
                            else{
                                //Return Error
                                print("Server responded  event_id=null")
                                var  errorBean = ErrorBean()
                                errorBean.statusCode = 400
                                errorBean.description = "Failed to Create Event"
                                callBack?(result: errorBean, statusCode: errorBean.statusCode )
                            }
                            
                            return

                        }
                    }
                }
               
                else{
                    let showEventBean = Mapper<CreateEventResultBean>().map(jsonResult)!
                    callBack?(result: showEventBean.event, statusCode: statusCode )
                    return
                }
               
            }
            else{
                print(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
        })
    }

    
    func doClaim(objShowEventBean: ShowEventBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("doClaim")
      // var event_id = String(gObjUsers.id)
       // var user_id = String(gObjShowEventBean.user_id)
        strURL =  CREATE_CLAIMS
            //+ events + USER_CLAIM + String(objClaimBean.user_id)
         // strURL =  CREATE_CLAIMS + "?" + "event_id=" + event_id + "&" + "user_id=" + user_id
        let JSONString = Mapper().toJSONString(objShowEventBean, prettyPrint: true)
        
        doPost(JSONString!, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
                callBack?(result: claimEventBean, statusCode: statusCode )
                return
            }
            else{
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
        })
    }

    
    func doCancelClaim(objEventID: ShowEventBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        var strClaimID = String(objEventID.claim_id)
        strURL =  CLAIMS + String(objEventID.claim_id) + CANCEL_CLAIMS
        
     //   let JSONString = Mapper().toJSONString(strClaimID, prettyPrint: true)
        
        doDelete(strClaimID, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
          if(status) {
            var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
            callBack?(result: claimEventBean, statusCode: statusCode )
            return
          } else {
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
            
            
        })
        
    }
    
    
    func doAcceptClaim(strClaimEventId : String ,strClaimid : String,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        var strEventId = String(strClaimEventId)
        var strClaimid = String(strClaimid)
         strURL =  CLAIMS_LIST + "/" + TEACHER_CONFIRM + "?" + "event_id=" + strEventId + "&" + "claim_id=" + strClaimid
        
        doPost(strEventId,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
              print(jsonResult)
                 var acceptEventbean = Mapper<ClaimAcceptBean>().map(jsonResult)!
                 callBack?(result: acceptEventbean, statusCode: statusCode )
                 return
            }
            else {
                //print(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }

        
    })
    }
    func doSendMessage(objSendMessage : SendMessageBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        let JSONString = Mapper().toJSONString(objSendMessage, prettyPrint: true)

        
        var strUserId = String(objSendMessage.id)
        strURL =  SEND_MESSAGE + "/" + strUserId
        
        doPost(JSONString!,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
                callBack?(result: claimEventBean, statusCode: statusCode )
                return
            }
            else {
                //println(jsonResult)
               var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
            
            
        })
    }
    
    func doRejectClaim(strClaimid:String,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
    
   
    var strClaimid = String(strClaimid)
    strURL =  CLAIMS_LIST + "/" + strClaimid + "/"  + REJECT
    doDelete(strClaimid,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
    
    if(status){
        var claimEventBean = Mapper<ClaimEventBean>().map(jsonResult)!
        callBack?(result: claimEventBean, statusCode: statusCode )
        return
    }
    else {
        //println(jsonResult)
        var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
        callBack?(result: errorBean, statusCode: statusCode )
        return
    }
    
    
    })
    }

    
    func doCancelEvent(objEventID: ShowEventBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        var strEventID = String(objEventID.id)
        strURL =  EVENT + String(objEventID.id) + CANCEL_EVENT
        
        //   let JSONString = Mapper().toJSONString(strClaimID, prettyPrint: true)
        
        doDelete(strEventID, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            if(status) {
                print(jsonResult)
                var cancelEventBean = Mapper<CancelEventBean>().map(jsonResult)!
                callBack?(result: cancelEventBean, statusCode: statusCode )
                return
            } else {
                print(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
            
            
        })
        
   


}
    
    
    func getUserProfile(strUserID: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get user profile make my school")
        strURL =   DEV_TARGET + USERS + strUserID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<usersBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    
    func getSchoolProfile(strSchoolID: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get school profile")
        strURL =  DEV_TARGET + SCHOOL + strSchoolID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<SchoolsBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }

    
    
    
    
    func doSignOut(callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        var strEmptyJson = gEmptyJSON
        strURL =   USERS + SIGN_OUT
       
        
        //let JSONString = Mapper().toJSONString(strClaimID:nil, prettyPrint: true)
        
        doDelete(strEmptyJson,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            if(status) {
                var signoutBean = Mapper<SignoutResponseBean>().map(jsonResult)!
               callBack?(result: signoutBean, statusCode: statusCode )
                return
            } else {
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
            
            
        })
        
    }
    
    
    
    func getMakeMySchool(strSchoolID: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get male my school")
        strURL =  DEV_TARGET + SCHOOL + MAKE_MINE + strSchoolID
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<MakeMySchoolBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }

    func doEditProfile(objUserProfile: MakeMySchoolListBean, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("PUT USER PROFILE")
        strURL =  USER_PROFILE
       
        let userJSONString = Mapper().toJSONString(objUserProfile, prettyPrint: true)
        doPut(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<EditUserProfileBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    func getMenuUserProfile(callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get user profile")
        strURL =   DEV_TARGET + USERS + PROFILE
        
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<UserBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
   
    func getAwardbadges(strSchoolID: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get award badges")
        strURL =  DEV_TARGET + USERS + AWARD_BADGES
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<SchoolsBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    func getNotification( callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("get Notification")
        strURL =   DEV_TARGET + NOTIFICATION
       
        doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showNotificationBean = Mapper<NotificationBean>().map(jsonResult)
                
                callBack?(result: showNotificationBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }
    func doDeleteNotification(callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        var strEmptyJson = gEmptyJSON
        strURL =   NOTIFICATION
        
        
        //let JSONString = Mapper().toJSONString(strClaimID:nil, prettyPrint: true)
        
        doDelete(strEmptyJson,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status) {
                var signoutBean = Mapper<SignoutResponseBean>().map(jsonResult)!
                callBack?(result: signoutBean, statusCode: statusCode )
                return
            } else {
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
            
            
        })
        
    }
    func postBadgesAward(badgesAwardToEvent:Bool, eventId:Int, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
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
        
        
        let strSubUrl = "?" + "award=" + strAward
        
        let strSubUrl2 = "&" + "event_id=" + strEventId
        
        strURL = USERS + AWARD_BADGES + strSubUrl + strSubUrl2
        
        
        
        //var JSONString = Mapper().toJSONString(objAwardBadges, prettyPrint: true)
        
        doPost(nil,addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
            if(status){
                let awardBadgeResponseBean = Mapper<AwardBadgeResponse>().map(jsonResult)!
                callBack?(result: awardBadgeResponseBean, statusCode: statusCode )
                return
            }
            else {
                //println(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
            
            
        })
    }
    
    func doRegisterDevice(objDeviceBean: DeviceBean, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        strURL = REGISTER_DEVICE
        let userJSONString = Mapper().toJSONString(objDeviceBean, prettyPrint: true)
        doPost(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<DeviceBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
        
    }
    func doReadNotification(strId: String , callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        strURL = NOTIFICATION + "/" + strId
            
        doPost(gEmptyJSON, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<DeviceBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
        
    }

    func doSaveSettings(objSaveSetting: SettingsBean, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("save setting PROFILE")
        strURL = USERS + SETTINGS
        
        let userJSONString = Mapper().toJSONString(objSaveSetting, prettyPrint: true)
        doPut(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<EditUserProfileBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }

    func doEditProfileAccount(objEditAccount: AccountEditListBean, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("PUT EDIT ACCOUNT PROFILE")
        strURL =  ACCOUNT
        
        let userJSONString = Mapper().toJSONString(objEditAccount, prettyPrint: true)
        doPut(userJSONString!, addAuthHeader: true,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            
            //print(jsonResult);
            
            if(status) {
                print(jsonResult)
                let showAccountEditBean = Mapper<AccountEditResponseBean>().map(jsonResult)
                
                callBack?(result: showAccountEditBean!, statusCode: statusCode )

                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }

    
    func doResetPassword(objResetPassword: ResetPasswordBean, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        print("Reset Password")
        strURL =   USERS + PASSWORD
        
        let userJSONString = Mapper().toJSONString(objResetPassword, prettyPrint: true)
        doPost(userJSONString!, addAuthHeader: false,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            print(jsonResult);
            
            if(status) {
                //    print(jsonResult)
                var showEventBean = Mapper<EditUserProfileBean>().map(jsonResult)
                
                callBack?(result: showEventBean!, statusCode: statusCode )
                
                return
            }
            else {
                
                print(jsonResult)
                let  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                
                callBack?(result: errorBean, statusCode: statusCode )
                
                return
                
                
            }
        })
    }

}
