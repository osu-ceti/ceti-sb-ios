//
//  SendMessageResBean.swift
//  Delphos
//
//  Created by Babu on 6/8/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class SendMessageResBean: Mappable {
    
   
    
    var state: Int?
    
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
       
        
        state    <- map["state"]
        
      
        
    }
}