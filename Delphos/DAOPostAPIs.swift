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

}
