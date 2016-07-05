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
    
    
    var event_title: String!
    
    var award:Bool?
    
    var event_id:Int?
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        
        badge_id        <- map["badge_id"]
        
        badge_url       <- map["badge_url"]
        
        event_title      <- map["event_title"]
        
        award           <- map["award"]
        
        event_id        <- map["event_id"]
        
        
    }
    
}