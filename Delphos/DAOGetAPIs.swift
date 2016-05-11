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
    
        print("doLogin")
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
}