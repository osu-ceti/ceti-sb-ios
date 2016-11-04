//
//  ResetPasswordListBean.swift
//  Delphos
//
//  Created by Babu on 7/27/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class ResetPasswordListBean: Mappable {
    var email:          String?
   
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        email       <- map["email"]
        
    }
    
}
