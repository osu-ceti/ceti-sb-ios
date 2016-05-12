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
        strURL =  DEV_TARGET + SHOW_ALL_EVENTS
        
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
    
     func searchEvent(strSearchEvent: String, callBack: ((result: AnyObject, statusCode: Int) -> Void)?) {
        
         strURL =  DEV_TARGET + SEARCH_EVENT + strSearchEvent
        
         doGet(addAuthHeader,callBack:{(jsonResult: AnyObject, status: Bool, statusCode: Int) in
            
            if(status) {
                print(jsonResult)
                var eventBean = Mapper<EventDisplayBean>().map(jsonResult)
                
                callBack?(result: eventBean!, statusCode: statusCode )
                
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