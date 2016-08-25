//
//  FacadeDelphos.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

//
//  DelegateDlphos.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import Swift

/**
 * Facade Class can take care of all exception in an application.
 */
class FacadeDelphos: NSObject {
    
   
    
    fileprivate let delegateDelphos: DelegateController
    
    /**
     * Constructor to initialize Delegate class
     */
    override init() {
        delegateDelphos = DelegateController()
    }
    
    /**
     * Relinquish control to Delegate class. This Facade class is added to support internationalization
     */
    func doTask(_ objCurrentController: BaseController, action enmAction: DelphosAction)
    {
        //call to delegate control
        delegateDelphos.delegateControl(objCurrentController,action: enmAction)
    }
    
}
