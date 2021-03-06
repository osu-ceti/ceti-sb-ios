//
//  DAOErrorCodes.swift
//  Delphos
//
//  Created by Prabhu on 5/7/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

/**
 * DAOErrorCodes shows Error messages of Http Codes.
 */
var SUCCESS: Int = 200;
var BAD_REQUEST: Int! = 400;
var UNAUTHORIZED_REQUEST: Int! = 401;
var APIKEY_EXPIRED: Int! = -1012;
var CONNECTION_FAILED:Int! = -1004;
var RESET_SUCCESS: Int = 201;
var ERROR_IN_PARSING: Int! = 600
var EMAIL_BAD_REQUEST: Int! = 422;


//Error Code Messages
var SUCCESS_MSG: String = "Success";
var BAD_REQUEST_MSG: String = "Bad Request. May be internet is down. Please check!";
var UNAUTHORIZED_REQUEST_MSG: String = "Invalid Email and Password";
var SERVER_ERROR_MSG = "Could not connect to the server."
var REGISTERATION_ERROR = "Failed to Register"
var SESSION_LOST: String = "Session Expired! Please Login"
var ERROR_PARSING_MSG : String = "Error while parsing response from server"
var ERROR_MSG_FROM_SERVER : String = "Server error! Please try after sometime."
var ERROR: String = "Error"
var EMAIL_ERROR = "Invalid Username/Email."
