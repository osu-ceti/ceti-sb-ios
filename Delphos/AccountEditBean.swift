//
//  AccountEditBean.swift
//  Delphos
//
//  Created by Babu on 7/19/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class AccountEditBean: Mappable {
    
    var id:                 Int!
    
    var name:               String?
    
    var email:              String?
    
    var role:               String?
    
    var password:         String?
    
    var confirm_password:    String?
    
    var current_password:    String?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        id                  <- map["id"]
        
        name                <- map["name"]
        
        email               <- map["email"]
        
        role                <- map["role"]
        
        password            <- map["password"]
        
        confirm_password     <- map["confirm_password"]
        
        current_password     <- map["current_password"]
        
        

        
    }
    
}
