//
//  DelphosGlobals.swift
//  Delphos
//
//  Created by lingaadm on 6/4/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

var gObjStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

var doPostAPIs: DAOServices!
var doGetAPIs: DAOServices!

var gObjHomeController : UINavigationController!
var gStrHomeControllerID: String = "HomeID"

var gObjLoginController : UINavigationController!
var gStrLoginControllerID: String = "loginId"

var gObjRegisterController : UINavigationController!
var gStrRegisterControllerID: String = "RegisterId"

var gObjEventShowController : UINavigationController!
var gStrEventShowControllerID: String = "eventShowID"

var gObjCreateEventController : UINavigationController!
var gStrCreateEventControllerID: String = "CreateEventId"

var gObjSearchController : SearchController!
var gStrSearchControllerID: String = "searchID"

var gObjMessageController : UINavigationController!
var gStrMessageControllerID: String = "MessageId"

//var gObjUserProfileController : UINavigationController!
var gObjUserProfileController : UserProfileController!
var gStrUserProfileControllerID: String = "UserProfileId"

//var gObjSchoolProfileController : UINavigationController!
var gObjSchoolProfileController : SchoolProfileController!
var gStrSchoolProfileControllerID: String = "SchoolProfileControllerId"

//var gObjPublicProfileController : UINavigationController!
var gObjPublicProfileController : PublicProfileController!
var gStrPublicProfileControllerID: String = "PublicProfileControllerId"

var gObjNotificationController : NotificationController!
//var gObjNotificationController : UINavigationController!
var gStrNotificationControllerID: String = "NotificationControllerId"

var gObjBadgesAwardController :UINavigationController!
var gStrBadgesAwardControllerID: String = "BadgesAwardControllerId"

var rightViewController: RightViewController!


var regularMenu = ["Home", "Settings", "Profile", "Logout","PushNotification"]
var gRegisterMenu = ["Login"]
var menus : [String] = regularMenu

var gEmptyJSON = "{}"

