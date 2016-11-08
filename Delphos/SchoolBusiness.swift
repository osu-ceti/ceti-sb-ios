//
//  SchoolBusiness.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation

let DEBUG: Bool = true
let DEV_URL: String = "http://ceti-test-env.elasticbeanstalk.com"
let DEV_TARGET: String  =  "http://ceti-test-env.elasticbeanstalk.com/api/"
//let DEV_URL: String = "http://192.168.1.3:3000"
//let DEV_TARGET: String  =  "http://192.168.1.3:3000/api/"
let DEV_TARGET_NO_API: String  =  "http://192.168.1.3:3000/"

//let DEV_URL: String = "https://www.school2biz.com";
//let DEV_TARGET: String =  "https://www.school2biz.com/api/"

let PRO_URL: String = "https://www.school2biz.com";
let PRO_TARGETL: String =  "https://www.school2biz.com/api/"
let AWS_S3: String = "https://s3-us-west-1.amazonaws.com/ceti-sb/badges/"
let NONE: String = "None"
let TEACHER: String = "Teacher"
let SPEAKER: String = "Speaker"
let BOTH: String = "Both"
let TAG: String = "school_business"
let POST = "POST"
let GET = "GET"
let PATCH = "PATCH"
let DELETE = "DELETE"
let PUT = "PUT"




//API URLS
let LOGIN_URL: String = "users/sign_in"
let REGISTER_URL: String = "users/sign_up"
let EVENT = "events/"
let SHOW_ALL_EVENTS = EVENT + "my_events"
let SHOW_APPROVED = EVENT + "pending_events"
let SHOW_CLAIMS = EVENT + "pending_claims"
let SHOW_CONFIRMED = EVENT + "confirmed"

let SHOWCLAIMSDATA = "pending_claims"
let EVENT_ID = "event_id"
let CLAIMS_LIST = "claims"

let SCHOOL = "schools/"
let USERS = "users/"
let SEARCH_EVENT = "?search="
let EVENT_URL = "events"
let CREATE_EVENT_URL = EVENT_URL + "/create"

let CREATE_CLAIMS = EVENT_URL + "/claim_event"
let USER_CLAIM = "&user_id="
let CLAIMS = "claims/"
let CANCEL_CLAIMS = "/cancel"
let CANCEL_EVENT = "/cancel"
let TEACHER_CONFIRM = "teacher_confirm"
let REJECT = "reject"
let SEND_MESSAGE = "send_message"
let SIGN_OUT = "sign_out"
let MAKE_MINE = "make_mine/"
let USER_PROFILE = "users"
let PROFILE = "profile"

let NOTIFICATION = "notifications"
let AWARD_BADGES = "award_badge"
let BADGES = "badges"

let ACCOUNT = "account"

let PASSWORD = "password/"
let NEW = "new"


let REGISTER_DEVICE = "register_device"

let SETTINGS = "settings"

let ZIP_URL = "?zip="

let RADIUS_URL = "&radius="

let COMMIT_URL = "&commit=Near+Me&search="

let NEAR_ME_URL = "/near_me"

let LOCATION_URL_TRUE = "&location=true"

let LOCATION_URL = "&location="






func getTarget() -> String {
    if(DEBUG) {
        return DEV_TARGET
    }
    else {
        return DEV_URL
    }
}
