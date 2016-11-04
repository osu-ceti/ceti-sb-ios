//
//  ClaimListBean.swift
//  Delphos
//
//  Created by Babu on 6/2/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class  ClaimListBean: Mappable {
    
    
    
    var claims:[ClaimListClaimBeanBean]!
    
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        claims    <- map["claims"]
        
    }
}
