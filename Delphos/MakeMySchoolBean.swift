//
//  MakeMySchoolBean.swift
//  Delphos
//
//  Created by Babu on 6/21/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class MakeMySchoolBean: Mappable {
    
    
    
    var profile: MakeMySchoolListBean!
    
    var state: Int!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
     
        
        profile    <- map["profile"]
        
        state    <- map["state"]

        
    }
}

