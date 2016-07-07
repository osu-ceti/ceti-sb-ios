//
//  DelphosEnums.swift
//  Delphos
//
//  Created by Babu on 5/23/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import Foundation

//Enum for HomController Event Listing type
enum EventListingType: UInt{
    case ALL
    case APPROVED
    case CLAIMS
    case CONFIRMED    
}

enum RoleType: UInt{
    case TEACHER = 1
    case SPEAKER = 2
    case BOTH = 3


}

enum NOTIFICATION_TYPE:Int{

    case CLAIM              = 0
    case CONFIRM_SPEAKER    = 1
    case EVENT_UPDATE       = 2
    case MESSAGE            = 3
    case AWARD_BADGE        = 4
    case NEW_BADGE          = 5
    case CANCEL             = 6
    case REJECT_CLAIM       = 7
    case CANCEL_CLAIM       = 8
    case CANCEL_SPEAKER     = 9

}

