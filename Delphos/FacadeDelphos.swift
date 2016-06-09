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
    
    private let delegateDiphos: DelegateController
    
    /**
     * Constructor to initialize Delegate class
     */
    override init() {
        delegateDiphos = DelegateController()
    }
    
    /**
     * Relinquish control to Delegate class. This Facade class is added to support internationalization
     */
    func doTask(objCurrentController: UIViewController, action enmAction: DelphosAction)
    {
        //call to delegate control
        delegateDiphos.delegateControl(objCurrentController,action: enmAction)
    }
    
}
