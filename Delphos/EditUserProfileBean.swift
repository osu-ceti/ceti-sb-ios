//
//  EditUserProfileBean.swift
//  Delphos
//
//  Created by Babu on 6/24/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class EditUserProfileBean: Mappable {
    
  
    var state:Int!
    
    var user: searchUserListBean!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        
        state    <- map["state"]
        
        
        user    <- map["user"]
        
    }
}

