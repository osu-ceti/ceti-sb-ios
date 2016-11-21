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
class UserBean: Mappable {
    
    var authentication_token: String!
    
    var biography: String!
    var business: String!
    var created_at: String?
    
    var current_sign_in_at: String?
    
    var current_sign_in_ip: String?
    
    var deleted_at: String?
    
    var email: String!
    var encrypted_password: String?
    var grades: String!
    var id: Int!
    var job_title: String!
    var last_sign_in_at: String?
    
    var last_sign_in_ip: String?
    var name: String!
    var remember_created_at: String?
    var reset_password_sent_at: String?
    var reset_password_token: String?
    var role: Int!
    var school_id: Int!
    var school_name: String!
    var set_claims: Int?
    var set_confirm: Int?
    var set_updates: Int?
    var sign_in_count: Int?
    var speaking_category: String?
    var updated_at: String?
    
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        authentication_token    <- map["authentication_token"]
        
        biography    <- map["biography"]
        
        business     <- map["business"]
        
        created_at    <- map["created_at"]
        
        current_sign_in_at    <- map["current_sign_in_at"]
        
        current_sign_in_ip    <- map["current_sign_in_ip"]
        
        deleted_at     <- map["deleted_at"]
        
        email     <- map["email"]
        
        encrypted_password    <- map["encrypted_password"]
        
        grades    <- map["grades"]
        
        id    <- map["id"]
        
        job_title  <- map["job_title"]

        last_sign_in_at  <- map["last_sign_in_at"]
        
        last_sign_in_ip  <- map["last_sign_in_ip"]
        
        name   <- map["name"]
        
        remember_created_at <- map["remember_created_at"]
        
        reset_password_sent_at  <- map["reset_password_sent_at"]
        
        reset_password_token  <- map["reset_password_token"]
        
        role   <- map["role"]
        
        school_id    <- map["school_id"]
        
        school_name        <- map["school_name"]
        
        set_claims        <- map["set_claims"]
        
        set_confirm        <- map["set_confirm"]
        
        set_updates        <- map["set_updates"]
        
        sign_in_count        <- map["sign_in_count"]
        
        speaking_category        <- map["speaking_category"]
        
        updated_at        <- map["updated_at"]

    }
}
