//
//  CreateEventController.swift
//  Delphos
//
//  Created by Babu on 5/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

class CreateEventController: UIViewController {
    
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContents: UITextField!
    @IBOutlet weak var txtTags: UITextField!
  
 
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var stratTimePicker: UIDatePicker!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var endTime: UITextField!
   var datePickerView = UIDatePicker()
    var dateFormatter = NSDateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // datepickerstartdate.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
      //  start.frame = CGRectMake(10, 30, 30, 20)
        var myObject = NSDate()
        let futureDate = myObject.dateByAddingTimeInterval(2*60*60*24);
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH-mm-ss-a"
        startTime.text = dateFormatter.stringFromDate(myObject)
        endTime.text = dateFormatter.stringFromDate(futureDate)
        self.startTime.hidden = true
        self.endTime.hidden = true

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartDateTouch(sender: UITextField) {
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            datePickerView = UIDatePicker(frame: CGRectMake(inputView.frame.origin.x + 250 , 40, 0, 0))
        }
        else {
            datePickerView = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        }
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView)
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
  
    @IBAction func EndDateTouch(sender: UITextField) {
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            datePickerView = UIDatePicker(frame: CGRectMake(inputView.frame.origin.x + 250 , 40, 0, 0))
        }
        else {
            datePickerView = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        }
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView)
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("handleEndDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    /**
     * Method call to showing date picker for start date in a correct format
     */
    func handleDatePicker(sender: UIDatePicker) {
        dateFormatter.dateFormat = "YYYY-MM-dd"
        startDate.text = dateFormatter.stringFromDate(sender.date)
    }
    /**
     * Method call do action for done in datePicker
     */
    
    func handleEndDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        endDate.text = dateFormatter.stringFromDate(sender.date)
}


    func doneButton(sender:UIButton)
    {
        startDate.resignFirstResponder() // To resign the inputView on clicking done.
        endDate.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    
    @IBAction func startTimePickerChange(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss-a"
        var strDate = dateFormatter.stringFromDate(sender.date)
        startTime.text = strDate

    }
    
    @IBAction func endTimePickerChange(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss-a"
        var strDate = dateFormatter.stringFromDate(sender.date)
        endTime.text = strDate
        

    }
    
    

   
//    func datePickerChanged(sender:UIDatePicker) {
//        var dateFormatter = NSDateFormatter()
//        
//        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
//        
//        var strDate = dateFormatter.stringFromDate(sender.date)
//        txtStartDate.text = strDate
//    }
    
    @IBAction func btnPostEvent(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.CREATE_EVENT)
    }


   }