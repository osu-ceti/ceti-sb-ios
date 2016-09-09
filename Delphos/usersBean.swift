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
class usersBean: Mappable {
   
    var events: [EventBean]!
    
    var users: [userListBean]!
   
    var user: searchUserListBean!

    var data: UserBean!
    
    var badges:[UserProfileBadgesBean]!
    
    required init()
    {
        //Do not remove required for Initialization
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(_ map: Map) {
        
        events    <- map["events"]
        
        users    <- map["users"]
        
        user    <- map["user"]
        
        data    <- map["data"]
        
        badges    <- map["badges"]

    }
}
