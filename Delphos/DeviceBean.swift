//
//  DeviceBean.swift
//  Delphos
//
//  Created by lingaadm on 7/5/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class DeviceBean: Mappable {
    var token:          String?
    var device_name:    String?
    var state:          Int?
    var device_type:    String?

    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        token       <- map["token"]
        device_name <- map["device_name"]
        state       <- map["state"]
        device_type <- map["device_type"]
    }

}
