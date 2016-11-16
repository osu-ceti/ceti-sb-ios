//
//  Logger.swift
//  Delphos
//
//  Created by lingaadm on 8/10/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation
import CocoaLumberjack

let INFO_MSG:String = "INFO: "
let DEBUG_MSG:String = "DEBUG: "
let ERROR_MSG:String = "ERROR: "

enum LoggingLevel{
    case INFO
    case DEBUG
    case ERROR
}
class Logger {
    
    
    func log(_ level :LoggingLevel, message:String)->Void{
        switch(level)
        {
        case .INFO:
            DDLogInfo(INFO_MSG + message)
            
        case .DEBUG:
            DDLogDebug(DEBUG_MSG + message)
            
        case .ERROR:
            
            DDLogError(ERROR_MSG + message)
        }
        
    }
}
