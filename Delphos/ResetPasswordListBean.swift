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
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        email       <- map["email"]
        
    }
    
}
