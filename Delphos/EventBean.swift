//
//  EventBean.swift
//  Delphos
//
//  Created by Babu on 5/18/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class EventBean: Mappable {
    
    var event_start: String!
    
    var event_title: String!
    
    var id: Int!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        
        event_start    <- map["event_start"]
        
        event_title    <- map["event_title"]
        
        id              <- map["id"]
        
    }
    
}
