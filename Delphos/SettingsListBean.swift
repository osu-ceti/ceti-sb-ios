//
//  SettingsListBean.swift
//  Delphos
//
//  Created by Babu on 7/20/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class SettingsListBean: Mappable {
    
    var set_claims:          Bool!
    
    var set_confirm:         Bool!
    
    var set_updates:         Bool!
    
    
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        set_claims       <- map["set_claims"]
        
        set_confirm       <- map["set_confirm"]
        
        set_updates       <- map["set_updates"]
        
    }
    
}
