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

var gObjEventShowController : UINavigationController!
var gStrEventShowControllerID: String = "eventShowID"

var gObjCreateEventController : UINavigationController!
var gStrCreateEventControllerID: String = "CreateEventId"

var gObjSearchController : SearchController!
var gStrSearchControllerID: String = "searchID"

var rightViewController: RightViewController!


var regularMenu = ["Home", "Settings", "Profile", "Logout"]
var gRegisterMenu = ["Login"]
var menus : [String] = regularMenu
