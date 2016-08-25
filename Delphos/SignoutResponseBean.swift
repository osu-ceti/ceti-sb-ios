
//
//  SignoutResponseBean.swift
//  Delphos
//
//  Created by Babu on 6/18/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//


import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class SignoutResponseBean: Mappable {
    
    
    var message:String!
    
    var status:Int!
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        
        message    <- map["message"]
        
        status    <- map["status"]
        
    }
}
