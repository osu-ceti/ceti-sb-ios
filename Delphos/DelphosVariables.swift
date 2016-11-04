//
//  DelphosStrings.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation
import UIKit


var gObjEventBean : HomeController!
var gObjEventDisplayBean : EventDisplayBean!
var gObjUsersBean : usersBean!
var gEventID : Int!
var gObjShowEventBean: ShowEventBean!
var gBtnRadioValue: String!
var gObjSearchBean = SearchBean()
var gBtnRegisterRadio: String!
var gObjUserBean : UserBean!

var gObjSearchUserListBean : searchUserListBean!
var gSearchValue: Int!
var gObjUsers: UserBean!

var gObjCreateEvent : CreateEventBean!

var gClaimEventId : Int!



var gClaim: String!

var gEditEvent:String!

var gCancelEvent:String!

var gCancelClaim:String!

var gClaimDetailId:Int!

var gClaimUserName:String!

var gUserId:Int!

var gClaimUser_id:Int!

var gClaimSpeakerName:String!


var gNotificationCount:Int! = 0

var gBtnNotificationCount:UIBarButtonItem  = UIBarButtonItem()

var gBadgesAwardToEvent:Bool!

var gNotificationNType = NOTIFICATION_TYPE.none

var gAwardNtype:Int!

var gBadgeid:Int!

var gSearchUserProfile:Int!

var gActUserId:Int! = 0

var gSpeakerId:Int! = 0

var gSpeakerName:String!

var gUserProfileMessage:Bool!

var gSchoolNameSelect:Bool!

var gPasswordCheck:String!

var gUserVIewBadgeId:Int!

var gActUserName:String!
var gEventTitle:String!

var gSchoolId:Int!

var strUserProfileId:Int = 0

var notificationPage:Int = 1

var NotificationFirstArray: [NotificationListBean]!
var NotificationSecondArray:[NotificationListBean]!

var gClaimsListDetails:ClaimListClaimBeanBean!

var gClaimsList:ClaimListBean!

var gEventAcceptBean:ClaimAcceptBean!

var gObjUserDisplayBean : EventBean!

var gObjSearchSchoolListBean : searchSchoolListBean!

var gObjSchoolImage:String!


var gObjMakeMySchoolListBean : MakeMySchoolListBean!

var gObjSchoolListBean : SchoolsDisplayBean!

var gObjSchoolBean : SchoolsBean!

var gObjUserProfileBadgesBean : UserProfileBadgesBean!

var viewBadgeBean:UserProfileBadgesBean!

var gPublicEditaccountBean: UserBean!

var gUsers = "users"

var gSchools = "schools"

var gEvents = "events"

var gEmptyString = DelphosStrings.EMPTY_STRING

var gSearchTextErrorMsg = "Please fill the search box with the search query"

var gZipcodeTextErrorMsg = "Please fill the search form with both zipcode & radius"

var bgColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */


