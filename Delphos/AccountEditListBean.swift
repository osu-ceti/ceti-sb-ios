//
//  AccountEditBean.swift
//  Delphos
//
//  Created by Babu on 7/19/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class AccountEditListBean: Mappable {
    
    var user: AccountEditBean!
    
   
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        
        user                  <- map["user"]
        
            }
    
}
