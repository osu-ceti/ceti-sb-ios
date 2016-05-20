//
//  SchoolBusiness.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation


let DEBUG: Bool = true
//let DEV_URL: String = "http://ceti-test-env.elasticbeanstalk.com"
//let DEV_TARGET: String  =  "http://ceti-test-env.elasticbeanstalk.com/api/"
let DEV_URL: String = "http://192.168.1.3:3000"
let DEV_TARGET: String  =  "http://192.168.1.3:3000/api/"
let PRO_URL: String = "https://www.school2biz.com";
let PRO_TARGETL: String =  "https://www.school2biz.com/api/"
let AWS_S3: String = "https://s3-us-west-1.amazonaws.com/ceti-sb/badges/"
let NONE: String = "None"
let TEACHER: String = "Teacher"
let SPEAKER: String = "Speaker"
let BOTH: String = "Both"
let TAG: String = "school_business"
let LOGIN_URL: String = "users/sign_in"
let REGISTER_URL: String = "users/sign_up"
let SHOW_ALL_EVENTS = "events/my_events"
let EVENT = "events/"
let SCHOOL = "schools/"
let USERS = "users/"
let SEARCH_EVENT = "?search="
let CREATE_EVENT_URL = "events/create"

let CREATE_CLAIMS = "events/claim_event"
let USER_CLAIM = "&user_id="
let CLAIMS = "claims/"
let CANCEL_CLAIMS = "/cancel"



func getTarget() -> String {
    if(DEBUG) {
        return DEV_TARGET
    }
    else {
        return DEV_URL
    }
}