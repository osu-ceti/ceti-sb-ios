//
//  ClaimAcceptBean.swift
//  Delphos
//
//  Created by Babu on 6/14/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class  ClaimAcceptBean: Mappable {
    
    
    
    var event: ShowEventBean!
    
    var status:Int!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        event    <- map["event"]
        
       status    <- map["status"]
        
    }
}
