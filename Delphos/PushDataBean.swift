//
//  DeviceBean.swift
//  Delphos
//
//  Created by lingaadm on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class PushDataBean: Mappable {
    
    var badge_url:      String?
    var count:          Int!
    var event_id:       Int?
    var event_name:     String?
    var message:        String?
    var n_type:         String?
    var speaker_name:   String?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        badge_url       <- map["badge_url"]
        count           <- map["count"]
        event_id        <- map["event_id"]
        event_name      <- map["event_name"]
        message         <- map["message"]
        n_type          <- map["n_type"]
        speaker_name    <- map["speaker_name"]
    }
    
}
