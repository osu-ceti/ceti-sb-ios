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
class searchUserListBean: Mappable {
    
    var id: Int!
    
    var name: String!
    
    var role: String!
    
    var grades: String!
    
    var job_title: String!
    
    var business: String?
    
    var biography: String?
    
    var category: String?
    
    var school_id: Int!
    
    var school_name: String!
    
    var events: [EventBean]?
    
    var badges: [BadgesBean]?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        
        id    <- map["id"]
        
        name    <- map["name"]
        
        role    <- map["role"]
        
        grades    <- map["grades"]
        
        job_title    <- map["job_title"]
        
        business    <- map["business"]
        
        category    <- map["category"]
        
        school_id    <- map["school_id"]
        
        school_name    <- map["school_name"]
        
        biography    <- map["biography"]
        
        events    <- map["events"]
        
        badges    <- map["badges"]
    }
}
