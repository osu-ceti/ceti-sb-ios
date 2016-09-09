//
//  Logger.swift
//  Delphos
//
//  Created by lingaadm on 8/10/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation

let INFO_MSG:String = "INFO: "
let DEBUG_MSG:String = "DEBUG: "
let ERROR_MSG:String = "ERROR: "

enum LoggingLevel{
    case info
    case debug
    case error
}
class Logger {
    func log(_ level :LoggingLevel, message:String)->Void{
        switch(level)
        {
            case .info:
                NSLog(INFO_MSG + message)
            
            case .debug:
                NSLog(DEBUG_MSG + message)
            
            case .error:
                NSLog(ERROR_MSG + message)
        }
        
    }
}
