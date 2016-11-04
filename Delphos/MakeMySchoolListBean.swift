//
//  MakeMySchoolBean.swift
//  Delphos
//
//  Created by Babu on 6/21/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class MakeMySchoolListBean: Mappable {
    
    
    var authentication_token:String!
    
    var biography:String!
    
    var business:String!
    
    var created_at:String!
    
    var deleted_at:String!
    
    var email:String!
    
    var grades:String!
    
    var id:Int!
    
    var job_title:String!
    
    var name:String!
    
    var role:String!
    
    var school_id:Int!
    
    var set_claims:String!
    
    var set_confirm:String!
    
    var set_updates:String!
    
     var speaking_category:String!
    
    var updated_at:String!

    
    
    
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
        
        business    <- map["business"]
        
        created_at    <- map["created_at"]
        
        deleted_at    <- map["deleted_at"]
        
        email    <- map["email"]
        
        grades    <- map["grades"]
        
         id    <- map["id"]
        
         job_title    <- map["job_title"]
        
         name    <- map["name"]
        
         role    <- map["role"]
        
         school_id    <- map["school_id"]
        
        set_claims    <- map["set_claims"]
       
        set_confirm    <- map["set_confirm"]
       
        set_updates    <- map["set_updates"]
       
        speaking_category    <- map["speaking_category"]
        
        updated_at    <- map["updated_at"]
        
                
    }
}

