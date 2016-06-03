//
//  DAOGetAPIs.swift
//  Delphos
//
//  Created by Prabhu on 5/7/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper


class DAOGetAPIs: DAOBase {
    
    var addAuthHeader = true
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
                    searchBean = Mapper<SearchEventBean>().map(jsonResult)
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
    
   

}