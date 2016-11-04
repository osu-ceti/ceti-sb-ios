//
//  CreateEventBeans.swift
//  Delphos
//
//  Created by Babu on 5/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class  CreateEventBean: Mappable {

    var title: String!
    
    var content: String!
    
    //var tag_list: String!
    
    var event_start: String!
    
    var event_end: String!
    
    var loc_id: Int!
    
    var time_zone: String!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        title       <- map["title"]
        
        content    <- map["content"]
        
      //  tag_list        <- map["tag_list"]
        
        event_start   <- map["event_start"]
        
        event_end     <- map["event_end"]
        
        loc_id       <- map["loc_id"]
        
        time_zone      <- map["time_zone"]
       
      
    }

}
