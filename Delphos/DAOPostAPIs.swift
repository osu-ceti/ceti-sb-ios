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


class DAOPostAPIs: DAOBase {
    
     func doLogin(objLoginParam: LoginBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
        
        
        print("doLogin")
        strURL =  LOGIN_URL
        let JSONString = Mapper().toJSONString(objLoginParam, prettyPrint: true)
        
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
                var userBean = Mapper<UserBean>().map(jsonResult)!
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
     //   var events = String(objClaimBean.event_id)
        strURL =  CREATE_CLAIMS
            //+ events + USER_CLAIM + String(objClaimBean.user_id)
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
    func doCancelEvent(objEventID: ShowEventBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        var strEventID = String(objEventID.id)
        strURL =  EVENT + String(objEventID.id) + CANCEL_EVENT
        
        //   let JSONString = Mapper().toJSONString(strClaimID, prettyPrint: true)
        
        doDelete(strEventID, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            if(status) {
                var cancelEventBean = Mapper<CancelEventBean>().map(jsonResult)!
                callBack?(result: cancelEventBean, statusCode: statusCode )
                return
            } else {
                //println(jsonResult)
                var  errorBean = Mapper<ErrorBean>().map(jsonResult)!
                callBack?(result: errorBean, statusCode: statusCode )
                return
            }
            
            
        })
        
    }


}
