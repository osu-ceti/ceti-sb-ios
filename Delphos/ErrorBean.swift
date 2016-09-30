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
class ErrorBean: Mappable {
    
    var description: String!
    
    var exception: String!
    
    var reasonPhrase: String!
    
    var statusCode: Int!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        
        description    <- map["description"]
        
        exception    <- map["exception"]
        
        reasonPhrase    <- map["reasonPhrase"]
        
        statusCode    <- map["statusCode"]
        
    }
}
