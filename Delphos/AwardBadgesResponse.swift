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
    var claim_id:       Int!
    var event_name:     String!
    var isAwarded:      Bool!
    var speaker_name:   String!
    var isRejected:      Bool?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        badge_url           <- map["badge_url"]
        claim_id            <- map["claim_id"]
        event_name          <- map["event_name"]
        isAwarded           <- map["isAwarded"]
        speaker_name        <- map["speaker_name"]
        isRejected           <- map["isRejected"]

        
        
    }
    
}
