//
//  searchSchoolsListBean.swift
//  Delphos
//
//  Created by Babu on 6/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class searchSchoolListBean: Mappable {
    
    
    var address:String!
    
    var city:String!
    
    var id: Int!
    
    var name: String!
    
    var phone:String!
    
    var state:String!
    
    var zip:String!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        address    <- map["address"]
        
        city    <- map["city"]
        
        id    <- map["id"]
        
        name    <- map["name"]
        
        phone    <- map["phone"]
        
        state    <- map["state"]
        
        zip    <- map["zip"]
        
           }
}
