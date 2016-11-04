//
//  CreateEventResultBean.swift
//  Delphos
//
//  Created by Babu on 5/20/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class  CreateEventResultBean: Mappable {
    
    var state: Int!
    
    var event: CreateEventResultEventBean!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        state    <- map["state"]
        event    <- map["event"]
    }
    
        
}
