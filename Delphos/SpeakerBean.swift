//
//  SpeakerBean.swift
//  Delphos
//
//  Created by Haripriya on 6/15/17.
//  Copyright © 2017 Ontoborn. All rights reserved.
//

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
class SpeakerBean: Mappable {
    
    var id: Int!
    
    var name: String!
    
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        id    <- map["id"]
        
        name    <- map["name"]
        
       
        
    }
    
}

