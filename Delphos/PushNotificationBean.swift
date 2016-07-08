//
//  DeviceBean.swift
//  Delphos
//
//  Created by lingaadm on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class PushNotificationBean: Mappable {
    var aps:        PushAPSBean?
    var data:       PushDataBean?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        aps         <- map["aps"]
        data        <- map["data"]
    }
    
}
