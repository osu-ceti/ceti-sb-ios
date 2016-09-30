//
//  ResetPasswordBean.swift
//  Delphos
//
//  Created by Babu on 7/27/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class ResetPasswordBean: Mappable {
    var utf8:           String?
    var authenticity_token : String?
    var user:          ResetPasswordListBean!
    var commit:        String?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        utf8                    <- map["utf8"]
         authenticity_token       <- map["authenticity_token"]
         user               <- map["user"]
         commit             <- map["commit"]
        
    }
    
}
