//
//  SchoolListBean.swift
//  Delphos
//
//  Created by Babu on 6/30/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit
import ObjectMapper

class SchoolListBean: Mappable {
    
    var city_state: String!
    
    var id: Int!
    
    var school_name: String!
    
    var address: String?
    
    var badge_id : Int?
    
    var mail_city: String?
    
//    var cdcode : Int?
//    
//    var charter : Int?
//    
//     var county_name: String?
//    
//    var county_number : Int?
//    
//    var created_at: String?
//    
//    var edu_agency: String?
//    
//    var fipst: Int?
//    
//    var grade_hi: Int?
//    
//    var grade_lo: Int?
//    
//    var latitude: String?
//    
//    var leaid: Int?
//    
//    var loc_addr: String?
//    
//    var loc_city: String?
//    
//    var loc_state : String?
//    var loc_zip : String?
//    var loc_zip4 : String?
//    var longitude : String?
//    var mail_addr : String?
//    var mail_city: String?
//    var mail_state : String?
//    var mail_zip : String?
//    
//    var mail_zip4 : String?
//    var ncessch : Int?
//    var phone : Int?
//    var schno : Int?
//    //var school_name :String?
//    var school_type : Int?
//    var search_vector :String?
//    
//    var seasch: Int?
//    var status : Int?
//    var stid: Int?
//    var survey_year : Int?
//    var union: Int?
//    var updated_at: String?
//    var  urban_local: Int?
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        
        city_state      <- map["city_state"]
        
        id              <- map["id"]
        
        school_name      <- map["school_name"]
        
         address      <- map["address"]
        
         badge_id      <- map["badge_id"]
        
         mail_city      <- map["mail_city"]
        
    }
    
}
