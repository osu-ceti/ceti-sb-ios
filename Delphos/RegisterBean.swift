/**
 * FileName     :   ErrorBean.swift
 * Created by   :   Venkat
 * Date Created :   5/19/2015
 * Description  :   ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 * All Copyrights reserved
 */

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class  RegsiterBean: Mappable {
    
    var email: String!
    
    var password: String!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        email    <- map["email"]
        
        password    <- map["password"]
        
        
    }
}
