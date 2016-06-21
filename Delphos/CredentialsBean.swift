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
class  CredentialsBean: Mappable {
    
    var email: String!
    
    var password: String!
    
    var name : String?
    
    var role :String?
    
    var school_id : String?
    
    var password_confirmation: String?
    
    var id: Int!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        email       <- map["email"]
        
        password    <- map["password"]
        
        name        <- map["name"]
        
        role        <- map["role"]
        
        school_id   <- map["school_id"]
        
        password_confirmation <- map["password_confirmation"]
        
        //dummy
        id             <- map["id"]

        
    }
}
