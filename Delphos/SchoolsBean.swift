//
//  SchoolsBean.swift
//  Delphos
//
//  Created by Babu on 6/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class SchoolsBean: Mappable {
    
    var badge_url:String!
    
    var events: [EventBean]!
    
   // var users: [userListBean]!
    
    var school: searchSchoolListBean!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
         badge_url    <- map["badge_url"]
        
        events    <- map["events"]
        
       // users    <- map["users"]
        
        school    <- map["school"]
        
    }
}

