/**
 * FileName     :   ErrorBean.swift
 * Created by   :   Venkat
 * Date Created :   5/19/2015
 * Description  :   ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 * All Copyrights reserved
 */

import UIKit
import ObjectMapper

/**
 * ErrorBean Class to store ErrorBean details
 * returned from REST API JSON
 */
class  CreateEventResultEventBean: Mappable {
    
    var active: Bool!
//    
//    
    var complete: Bool!

    var content: String!
    
    var created_at: String!
    
    //Format - YYYY-MM-DD HH:mm a
    var event_end: String!
    
    var event_start: String!

    var id: Int!
    
    var loc_id: Int!
    
    var loc_name: String!
    
    var speaker_id: Int!
    
    var time_zone: String!
    
    var title: String!
    
    var updated_at: String!
    
    var user_id: Int!
    
    var user_name: String!

    var claim_id:Int!
    
     var speaker: String?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        claim_id  <- map["claim_id"]
        active    <- map["active"]
        
        complete    <- map["complete"]

        content    <- map["content"]
        
        created_at    <- map["created_at"]
        
        event_end    <- map["event_end"]
        
        event_start    <- map["event_start"]
        
        id    <- map["id"]
        
        loc_id    <- map["loc_id"]
        
        loc_name    <- map["loc_name"]
       
        
        speaker_id    <- map["speaker_id"]
        
        time_zone    <- map["time_zone"]
        
        title    <- map["title"]
        
        updated_at    <- map["updated_at"]
        
        user_id    <- map["user_id"]
        
        user_name    <- map["user_name"]
        
        speaker    <- map["speaker"]
        
    }
}
