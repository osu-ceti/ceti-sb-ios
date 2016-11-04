
//
//  RegistrationResponseBean.swift
//  Delphos
//
//  Created by Babu on 8/10/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class RegistrationResponseBean: Mappable {
    
    var state:        Int?
    var status:        String?
    var data: UserBean!
    var messages:   [String]?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        state        <- map["state"]
        status       <- map["status"]
        data         <- map["data"]
        messages     <- map["messages"]
        
        
    }
    
}
