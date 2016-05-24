//
//  CancelEventBean.swift
//  Delphos
//
//  Created by Babu on 5/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class CancelEventBean: Mappable {
    
    
    var message: String?
    
    var state: Int?
    
    var status: Int?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        message    <- map["message"]
        
        state    <- map["state"]
        
        status    <- map["status"]
        
    }
}
