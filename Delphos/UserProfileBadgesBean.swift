//
//  UserProfileBadgesBean.swift
//  Delphos
//
//  Created by Babu on 7/4/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class UserProfileBadgesBean: Mappable {
    
    var badge_id: Int!
    
    var badge_url: String!
    
    
    var event_title: String?
    
    var award:Bool?
    
    var event_id:Int?
    
    var event_name:String?
    
    var event_owner:String?
    
    var event_owner_id:Int?
    
    var school_name:String?
    
    var user_id:Int?
    
    var user_name:String?
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        
        badge_id        <- map["badge_id"]
        
        badge_url       <- map["badge_url"]
        
        event_title      <- map["event_title"]
        
        award           <- map["award"]
        
        event_id        <- map["event_id"]
        
        event_name        <- map["event_name"]
        
        event_owner        <- map["event_owner"]
       
        event_owner_id        <- map["event_owner_id"]
       
        school_name        <- map["school_name"]
        
        user_id        <- map["user_id"]
        
         user_name        <- map["user_name"]
    }
    
}
