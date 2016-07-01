//
//  SchoolListBean.swift
//  Delphos
//
//  Created by Babu on 6/30/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class SchoolListBean: Mappable {
    
    var city_state: String!
    
    var id: Int!
    
    var school_name: String!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        city_state      <- map["city_state"]
        
        id              <- map["id"]
        
        school_name      <- map["school_name"]
        
    }
    
}
