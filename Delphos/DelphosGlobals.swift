//
//  DelphosGlobals.swift
//  Delphos
//
//  Created by lingaadm on 6/4/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

var gObjStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
var rootViewController: UIViewController!
var logger: Logger!

var gStrDeviceToken: String!

var gObjHomeController : UINavigationController!
var gStrHomeControllerID: String = "HomeID"

var gObjLoginController : UINavigationController!
var gObjLoginViewController : LoginController!
var gStrLoginControllerID: String = "loginId"

var gObjRegisterController : UINavigationController!
var gStrRegisterControllerID: String = "RegisterId"

var gObjEventShowController : UINavigationController!
var gStrEventShowControllerID: String = "eventShowID"

var gObjCreateEventController : UINavigationController!
var gStrCreateEventControllerID: String = "CreateEventId"

var gObjSearchNavController : UINavigationController!
var gObjSearchController : SearchController!
var gStrSearchControllerID: String = "searchID"

var gObjMessageController : UINavigationController!
var gStrMessageControllerID: String = "MessageId"

var gObjUserProfileNavController : UINavigationController!
var gObjUserProfileController : UserProfileController!
var gStrUserProfileControllerID: String = "UserProfileId"

var gObjSchoolProfileNavController : UINavigationController!
var gObjSchoolProfileController : SchoolProfileController!
var gStrSchoolProfileControllerID: String = "SchoolProfileControllerId"

//var gObjPublicProfileControllerNav : UINavigationController!
var gObjPublicProfileController : PublicProfileController!
var gStrPublicProfileControllerID: String = "PublicProfileControllerId"


var gObjNotificationController : NotificationController!
var gObjNotificationControllerNav : UINavigationController!
var gStrNotificationControllerID: String = "NotificationControllerId"

var gObjBadgesAwardController :UINavigationController!
var gStrBadgesAwardControllerID: String = "BadgesAwardControllerId"

var gObjViewBadgeController :ViewBadgeController!
var gStrViewBadgeControllerID: String = "ViewBadgeControllerId"

var gObjBadgeController : BadgeController!
var gObjBadgeControllerNav : UINavigationController!
var gStrBadgeControllerID: String = "BadgeControllerId"


var gObjSettingsController : SettingsController!
//var gObjSettingsController : UINavigationController!
var gStrSettingsControllerID: String = "SettingsControllerId"

var gObjBackTocontroller: UIViewController!


var gObjAccountEditController : AccountEditController!
//var gObjAccountEditControllerNav : UINavigationController!
var gStrAccountEditControllerID: String = "AccountEditControllerId"

var gObjAboutController : AboutController!
var gObjAboutControllerNav : UINavigationController!
var gStrAboutControllerID: String = "AboutControllerId"

var rightViewController: RightViewController!

var gObjRightViewController = rightViewController

var regularMenu = ["Home", "Settings", "Profile","My Account","About", "Logout"]
var gRegisterMenu = ["Login"]
var menus : [String] = regularMenu

var gEmptyJSON = "{}"

var gObjNotificationInfo: AnyObject?

let userCredsStorage = NSUserDefaults.standardUserDefaults()



