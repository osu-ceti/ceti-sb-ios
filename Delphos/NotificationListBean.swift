//
//  NotificationListBean.swift
//  Delphos
//
//  Created by Babu on 7/2/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class NotificationListBean: Mappable {
    
    var act_user_id: Int!
    
    var act_user_name: String!
    
    var event_id: Int!
    
    var event_title: String!
    
    var id: Int!
    
    var n_type: Int!
    
    var read: Int!
    
    var user_id: Int!
    
    var user_name: String!

    
    
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
       
        act_user_id         <- map["act_user_id"]
        
        act_user_name       <- map["act_user_name"]
        
        event_id            <- map["event_id"]
        
        event_title         <- map["event_title"]
        
        id                  <- map["id"]
        
        n_type              <- map["n_type"]

        
        read                <- map["read"]

        
        user_id             <- map["user_id"]

        user_name           <- map["user_name"]

        
    }
    
}

