//
//  EventShowController.swift
//  Delphos
//
//  Created by Prabhu on 5/12/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class EventShowController: UIViewController {
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtSpeaker: UILabel!
    @IBOutlet weak var txtStartEvent: UILabel!
    @IBOutlet weak var txtEndDate: UILabel!
    @IBOutlet weak var txtLocation: UILabel!
    @IBOutlet weak var txtCreatedBy: UILabel!
    @IBOutlet weak var txtContent: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Event: ", gObjShowEventBean.content)
        
        self.txtTitle.text = gObjShowEventBean.title
        self.txtSpeaker.text = gObjShowEventBean.speaker
        self.txtStartEvent.text = gObjShowEventBean.event_start
        self.txtEndDate.text = gObjShowEventBean.event_end
        self.txtLocation.text = gObjShowEventBean.loc_name
        self.txtCreatedBy.text = gObjShowEventBean.user_name
        self.txtContent.text = gObjShowEventBean.content
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}