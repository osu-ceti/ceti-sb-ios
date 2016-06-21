//
//  EventDelegate.swift
//  Delphos
//
//  Created by lingaadm on 6/9/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import ObjectMapper

class EventDelegate: BaseDelegate{

    func showAllEvents(objCurrentContoller: UIViewController) {
        
        let  homeController = objCurrentContoller as! HomeController
        
        switch homeController.listType {
        case .ALL:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_ALL_EVENTS
            
        case .APPROVED:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_APPROVED
            
        case .CLAIMS:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_CLAIMS
            
        case .CONFIRMED:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_CONFIRMED
            
        default:
            doGetAPIs.strURL =  DEV_TARGET + SHOW_ALL_EVENTS
        }
        
        
        doGetAPIs.getAllEvents { (result: AnyObject,statusCode: Int) in
            
            let eventDisplayController = objCurrentContoller as! HomeController
            if(statusCode != 0){
                print("Show event")
                //var objEventDisplayBean = result as! EventDisplayBean
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    gObjEventDisplayBean = result as! EventDisplayBean
                    print("Show", objCurrentContoller)
                    
                    eventDisplayController.eventBeanArray = gObjEventDisplayBean.events
                    
                    //      print(eventDisplayController.eventBeanArray);
                    
                    eventDisplayController.tableView.reloadData()
                    
                })
            }
        }
    }
    
    func createEvent(objCurrentContoller: UIViewController){
        let createEventController = objCurrentContoller as! CreateEventController
        let strTitle = createEventController.txtTitle.text
        let strContents = createEventController.txtContents.text
        // let strTags = createEventController.txtTags.text
        let strStartDate: String = createEventController.startDate.text!
        let strStartTime: String = createEventController.startTime.text!
        let strEndDate: String = createEventController.endDate.text!
        let strEndTime: String = createEventController.endTime.text!
        var strEventStartDate =  strStartDate + " " + strStartTime
        var strEventEndDate =  strEndDate + " " + strEndTime
        var strEventTimeZone = createEventController.txtTimeZone.text
        var eventId = 0
        var objInputParamBean:CreateBean  = CreateBean()
        var objInputParamEventBean: CreateEventBean = CreateEventBean()
        
        
        print("strEventEndDate =" + strEventEndDate )
        print("strEventStartDate =" + strEventStartDate )
        
        objInputParamEventBean.title = strTitle
        objInputParamEventBean.content = strContents
        //  objInputParamEventBean.tag_list = strTags
        objInputParamEventBean.event_start = strEventStartDate
        objInputParamEventBean.event_end = strEventEndDate
        objInputParamEventBean.loc_id = gObjUserBean.school_id
        objInputParamEventBean.time_zone = strEventTimeZone
        objInputParamBean.event = objInputParamEventBean
        var eventBean: Mappable = objInputParamBean
        //DOA calls
        if(createEventController.isEdit){
            eventId = createEventController.eventId
            eventBean = objInputParamEventBean
        }
        
        doPostAPIs.doSaveEvent(createEventController.isEdit, eventId: eventId, objEventParam: eventBean){ (result: AnyObject, statusCode: Int) in
            
            if (statusCode == SUCCESS){
                print("create event Sucessfull")
                let resultBean: CreateEventResultEventBean = result as! CreateEventResultEventBean
                gObjShowEventBean = ShowEventBean()
                gObjShowEventBean.id = resultBean.id
                gObjShowEventBean.user_id = resultBean.user_id
                gObjShowEventBean.created_at = resultBean.created_at
                gObjShowEventBean.updated_at = resultBean.updated_at
                gObjShowEventBean.content = resultBean.content
                gObjShowEventBean.title = resultBean.title
                
                gObjShowEventBean.event_start = resultBean.event_start
                gObjShowEventBean.event_end = resultBean.event_end
                gObjShowEventBean.loc_id = resultBean.loc_id
                gObjShowEventBean.speaker_id = resultBean.speaker_id
                gObjShowEventBean.user_name = resultBean.user_name
                gObjShowEventBean.loc_name = resultBean.loc_name
                gObjShowEventBean.active = resultBean.active
                gObjShowEventBean.time_zone = resultBean.time_zone
                gObjShowEventBean.complete = resultBean.complete
                gObjShowEventBean.claim_id = 0
                self.showEventUI(objCurrentContoller)
                
                
            }
            else{
                print("create event failure")
                // Handle error
                self.showAlert(objCurrentContoller, strMessage: "Failed to Create Event")
            }
            
            
        }
        
    }
    
    func showEvent(objCurrentContoller: UIViewController) {
        var strUserDetail: String = String(gEventID)
        
        doGetAPIs.getEvent(strUserDetail,callBack: {(result: AnyObject,statusCode: Int)   in
            if(statusCode == SUCCESS) {
                gObjShowEventBean = result as! ShowEventBean
                self.showEventUI(objCurrentContoller)
                
            }
        })
    }
    
    
    func editEvent(objCurrentContoller: UIViewController){
        var editEventController:CreateEventController = instantiateVC(gStrCreateEventControllerID) as! CreateEventController
        editEventController.isEdit = true
        doNavigate(objCurrentContoller, toController: UINavigationController(rootViewController: editEventController),close: true)
        
    }
    
    func cancelEvent(objCurrentContoller: UIViewController) -> Bool {
        
        
        
        doPostAPIs.doCancelEvent(gObjShowEventBean){ (loginResult: AnyObject, statusCode: Int) in
            if (statusCode == SUCCESS){
                print("Cancel Event")
                 dispatch_async(dispatch_get_main_queue(), {
               // if(gObjHomeController == nil){
                    self.showAlert(objCurrentContoller, strMessage: "Event Cancel ")
                    gObjHomeController = self.fetchNavController(gStrHomeControllerID)
               // }
                objCurrentContoller.slideMenuController()?.changeMainViewController(gObjHomeController, close: false)
                })
                
            }
            else {
                 self.showAlert(objCurrentContoller, strMessage: "Event Not Cancel ")
                print("not Cancel Event")
               
            }
        }
        
        return true
    }

  
    
    


    
}