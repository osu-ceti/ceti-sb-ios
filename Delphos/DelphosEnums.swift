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
    case all
    case approved
    case claims
    case confirmed    
}

enum RoleType: UInt{
    case teacher = 1
    case speaker = 2
    case both = 3


}

enum NOTIFICATION_TYPE:Int{
    case none               = -1
    case claim              = 0
    case confirm_SPEAKER    = 1
    case event_UPDATE       = 2
    case message            = 3
    case award_BADGE        = 4
    case new_BADGE          = 5
    case cancel             = 6
    case reject_CLAIM       = 7
    case cancel_CLAIM       = 8
    case cancel_SPEAKER     = 9

}

