//
//  ClaimListBean.swift
//  Delphos
//
//  Created by Babu on 6/2/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class  ClaimListClaimBeanBean: Mappable {
    
    
    
    var business:String!
    
    var claim_id: Int!
    
    
    var event_id: Int!
    
    var job_title:String!
    
    var school_id:Int!
    
    var user_id: Int!
    
    var user_name: String!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        business    <- map["business"]
        
        claim_id    <- map["claim_id"]
        
        event_id    <- map["event_id"]
        
        job_title    <- map["job_title"]
        
        school_id    <- map["school_id"]
        
        user_id    <- map["user_id"]
        
        user_name    <- map["user_name"]
        
    }
}