//
//  CreateEventBeans.swift
//  Delphos
//
//  Created by Babu on 5/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class  CreateEventBean: Mappable {

    var title: String!
    
    var contents: String!
    
    var tags: String!
    
    var startdate: String!
    
    var enddate: String!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        title    <- map["title"]
        
    }

}