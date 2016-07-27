//
//  AccountEditResponseBean.swift
//  Delphos
//
//  Created by Babu on 7/20/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//



import UIKit
import ObjectMapper

class AccountEditResponseBean: Mappable {
    
    var state:Int!
    
    var user: UserBean!
    
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        state                  <- map["state"]
        
        user                  <- map["user"]
        
        
        
    }
    
}
