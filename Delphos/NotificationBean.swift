//
//  NotificationBean.swift
//  Delphos
//
//  Created by Babu on 7/2/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class  NotificationBean: Mappable {
    
    var count:Int!
    
    var notifications: [NotificationListBean]!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        count    <- map["count"]

        
        notifications    <- map["notifications"]
        
    }
}
