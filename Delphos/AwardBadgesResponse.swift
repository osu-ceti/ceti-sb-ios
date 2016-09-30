//
//  AwardBadgesResponse.swift
//  Delphos
//
//  Created by Babu on 8/27/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//




import UIKit
import ObjectMapper

class AwardBadgesResponse: Mappable {
    
    var badge_url:      String!
    var event_id:       Int!
    var event_name:     String!
    var isAwarded:      Int!
    var speaker_name:   String!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        badge_url           <- map["badge_url"]
        event_id            <- map["event_id"]
        event_name          <- map["event_name"]
        isAwarded           <- map["isAwarded"]
        speaker_name        <- map["speaker_name"]

        
        
    }
    
}
