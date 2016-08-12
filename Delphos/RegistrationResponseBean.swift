
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
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        state                    <- map["state"]
        status       <- map["status"]
        data               <- map["data"]
        
        
    }
    
}