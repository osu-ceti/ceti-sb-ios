//
//  DelegateDlphos.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * Delegate class that delegates control to all Models.
 */
class DelegateController: BaseDelegate {
    
    
    var rootController : UINavigationController!
    var objEventDelegate : EventDelegate!
    var objClaimsDelegate : ClaimsDelegate!
    var objUserDelegate : UserDelegate!
    var objSearchDelegate : SearchDelegate!
    
    
    override init() {
        doPostAPIs = DAOServices()
        doGetAPIs = doPostAPIs
        
        objEventDelegate = EventDelegate()
        objClaimsDelegate = ClaimsDelegate()
        objUserDelegate = UserDelegate()
        objSearchDelegate = SearchDelegate()
    }
        
    
    
    func delegateControl(objCurrentController: UIViewController, action enmAction: DelphosAction) {
       
        print("Delegate(delegateControl) - Action: \(enmAction)")
        
        switch(enmAction)
        {
        case .LOGIN:
            print("Login")
            objUserDelegate.login(objCurrentController)
            
        case .EVENT_ALL:
            print("Event All")
            objEventDelegate.showAllEvents(objCurrentController)

        case .REGISTER:
            print("Regsiter")
            objUserDelegate.register(objCurrentController)
            
        case .SHOW_EVENT:
            print("SHOW_EVENT")
            objEventDelegate.showEvent(objCurrentController)
            
        case .SEARCH_EVENT:
            print("SEARCH_EVENT")
            objSearchDelegate.searchEvent(objCurrentController)
            
        case.CREATE_EVENT:
            print("CREATE_EVENT")
            objEventDelegate.createEvent(objCurrentController)
            
        case .SHOW_SEARCH:
            print("SHOW_SEARCH")
            objSearchDelegate.showSearch(objCurrentController)
            
        case .CLAIM_EVENT:
            print("CLAIM_EVENT")
            objClaimsDelegate.claimEvent(objCurrentController)
            
        case .CANCEL_CLAIM:
            print("CANCEL CLAIM")
            objClaimsDelegate.cancelClaim(objCurrentController)
            
        case .EDIT_EVENT_SHOW:
            print("EDIT_EVENT_SHOW")
            objEventDelegate.editEvent(objCurrentController)
            
        case .CANCEL_EVENT:
            print("DELETE_EVENT")
            objEventDelegate.cancelEvent(objCurrentController)
            
        case .CLAIM_LIST:
            print("claim All List ")
             objClaimsDelegate.showClaimAllList(objCurrentController)
            
        case .CLAIM_LIST_DETAILS:
            print("CLAIM_LIST_DETAILS")
            objClaimsDelegate.showClaimListDetails(objCurrentController)
            
        case .CLAIM_ACCEPT:
            print("CLAIM ACCEPT")
            objClaimsDelegate.claimAccept(objCurrentController)
            
        case .CLAIM_REJECT:
            print("CLAIM REJECT")
             objClaimsDelegate.claimReject(objCurrentController)
        
        case .SEND_MESSAGE:
            objClaimsDelegate.sendMessage(objCurrentController)
            
        case .VIEW_MESSAGE_CONTROLLER:
           objClaimsDelegate.messageClick(objCurrentController)
            
        default:
            print("Error in delegate enum")


        }
    }
}


