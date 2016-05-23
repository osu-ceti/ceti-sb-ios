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
    func doSaveEvent(isEdit: Bool, eventId: Int, objEventParam: CreateBean,callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
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
        let JSONString = Mapper().toJSONString(objEventParam, prettyPrint: true)
        
        doUpdate(method,strInputParamsJson: JSONString!, addAuthHeader: true,callBack:{(jsonResult: NSDictionary, status:Bool, statusCode: Int) in
            
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
                            callBack?(result: showEventBean, statusCode: statusCode )
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

}
