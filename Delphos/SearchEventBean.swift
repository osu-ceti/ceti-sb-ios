//
//  SearchEventBean.swift
//  Delphos
//
//  Created by Babu on 5/28/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class SearchEventBean: Mappable {
    
    var association: String?
    
    var id: Int!
    
    var name: String!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        association    <- map["association"]
        
        id    <- map["id"]
        
        name    <- map["name"]
        
    }
}
