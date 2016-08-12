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
    case INFO
    case DEBUG
    case ERROR
}
class Logger {
    func log(level :LoggingLevel, message:String)->Void{
        switch(level)
        {
            case .INFO:
                NSLog(INFO_MSG + message)
            
            case .DEBUG:
                NSLog(DEBUG_MSG + message)
            
            case .ERROR:
                NSLog(ERROR_MSG + message)
        }
        
    }
}