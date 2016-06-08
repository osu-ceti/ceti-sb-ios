//
//  CreateEventController.swift
//  Delphos
//
//  Created by Babu on 5/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

class CreateEventController: NavController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
   
   
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContents: UITextField!
    @IBOutlet weak var txtTags: UITextField!
    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var requiredError: UILabel!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var txtTimeZone: UITextField!
    
    @IBOutlet weak var btnPostEvent: UIButton!
    
    
  
  
    var datePickerView = UIDatePicker()
    func getCurrentDate() -> NSDate{
        return NSDate()
    }
    var currentDate = NSDate()

    var dateFormatter   = NSDateFormatter()
    var endDatevalid   = NSDate()
    var startDatevalid  = NSDate()
    var startTimeValid  = NSDate()
    var endTimeValid    = NSDate()
    var startDateAndTime = NSDate()
    var endDateAndTime = NSDate()
    
    var isEdit = false
    var eventId = 0

    //let dataTimeZone = NSTimeZone.knownTimeZoneNames()
   // var timeAbb = iOStimeZones?.abbreviation
    let iOStimeZones = ["Eastern Time (US & Canada)"]
    
    @IBOutlet var scrolview: UIScrollView!
   
    @IBOutlet weak var timeZonePicker: UIPickerView!
   
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = true
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requiredError.hidden = true
       
       // txtTitle = UITextField(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 25))
        //self.view.addSubview(txtTitle)
        
                //Adding Navbar
//        setNavBar(self.view.frame.size.width)
//        searchBar.delegate = self
//        navigationBar.delegate = self;
//        backToView = "HomeID"

        
        // Make the navigation bar a subview of the current view controller
       // self.view.addSubview(navigationBar)
        
            // timeZonePicker.dataSource = self
            //  timeZonePicker.delegate = self
            // datepickerstartdate.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        //label and back ground design
        var color = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        
        view.backgroundColor = color

        txtTitle.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        txtContents.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        txtTags.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        startDate.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        endDate.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        //button
      
        
        
        //end bg design
        //start.frame = CGRectMake(10, 30, 30, 20)
        let startTimeSet = currentDate.dateByAddingTimeInterval(60*60);
        let endTimeSet = currentDate.dateByAddingTimeInterval(60*120);
        
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gTimeFormat
        startTime.text = dateFormatter.stringFromDate(startTimeSet)
        endTime.text = dateFormatter.stringFromDate(endTimeSet)
        self.startTimePicker.setDate(startTimeSet, animated: false)
        self.endTimePicker.setDate(endTimeSet, animated: false)
        txtTimeZone.text = "Eastern Time (US & Canada)"
      
        self.startTime.hidden = true
        self.endTime.hidden = true
        self.txtTimeZone.hidden = true
        
        
        var CurrentDateFormat = NSDateFormatter()
        CurrentDateFormat.dateFormat = gDateFormat
        self.startDate.text = CurrentDateFormat.stringFromDate(currentDate)
        self.endDate.text = CurrentDateFormat.stringFromDate(currentDate)
      
        if(isEdit){
            //Page is being edited 
            self.eventId = gObjShowEventBean.id

            self.txtTitle.text = gObjShowEventBean.title
            self.txtContents.text = gObjShowEventBean.content
            
            
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a 'EDT'"
            //DateFormatter.timeZone = NSTimeZone(abbreviation: "EDT")
            var eventStartDate =  dateFormatter.dateFromString(gObjShowEventBean.event_start)
            if  (eventStartDate != nil) {
                //String is already formatted
                
                //Start Date and Time
                
                self.startTimePicker.date = eventStartDate!
                
                dateFormatter.dateFormat = gTimeFormat
                self.startTime.text = dateFormatter.stringFromDate(eventStartDate!)
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.startDate.text =  dateFormatter.stringFromDate(eventStartDate!)
                
                startDatevalid = eventStartDate!
                
                
            }
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a 'EDT'"

           var eventEndDate =  dateFormatter.dateFromString(gObjShowEventBean.event_end)
            if  (eventEndDate != nil) {
                //String is already formatted
                
                //Start Date and Time
                
                self.endTimePicker.date = eventEndDate!
                
                dateFormatter.dateFormat = gTimeFormat
                self.endTime.text = dateFormatter.stringFromDate(eventEndDate!)
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.endDate.text =  dateFormatter.stringFromDate(eventEndDate!)
                
                endDatevalid = eventEndDate!
            }
            
            
            
            
//            else {
//                //Remove trailing Z
//
//                dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS"
//                var startDateindex = gObjShowEventBean.event_start.endIndex.advancedBy(-1)
//                var startDateSubStr = gObjShowEventBean.event_start.substringToIndex(startDateindex)
//                
//                
//                
//                eventStartDate =  dateFormatter.dateFromString(startDateSubStr)!
//                dateFormatter.dateFormat =  "yyyy-MM-dd hh:mm a"
//                self.startDate.text = dateFormatter.stringFromDate(eventStartDate!)
//                
//                dateFormatter.dateFormat =  "HH:mm"
//                self.stratTimePicker.date = eventStartDate!
//                self.startTime.text = dateFormatter.stringFromDate(eventStartDate!)
//                
//                
//            }
            
//           var spiltStartDateTime = gObjShowEventBean.event_start.componentsSeparatedByString(" ")
//            var spiltEndDateTime = gObjShowEventBean.event_end.componentsSeparatedByString(" ")
//            if(spiltStartDateTime.count == 1){

//                spiltStartDateTime = gObjShowEventBean.event_start.componentsSeparatedByString(gSplitDateTime)
//                spiltEndDateTime = gObjShowEventBean.event_end.componentsSeparatedByString(gSplitDateTime)
//            }
            
            
            
//            self.startDate.text = spiltStartDateTime[0]
//            
//            self.endDate.text = spiltEndDateTime[0]
//            
//            var timeOfStartPicker = spiltStartDateTime[1]
//            
//            var timeOfEndPicker = spiltEndDateTime[1]

            
            
            
            
//            self.stratTimePicker.date = eventStartDate!
//            self.stratTimePicker.timeZone = NSTimeZone(abbreviation: "EDT")
            
            //self.endTimePicker.date = dateFormatter.dateFromString(gObjShowEventBean.event_end)!
            
            
            
//            self.startTime.text =  spiltStartDateTime[1]
//            
//            self.endTime.text = spiltEndDateTime[1]
            
            
            btnPostEvent.setTitle("Update Event", forState: .Normal)
            
         
        }
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
        dateFormatter.dateFormat = gDateFormat
        startDatevalid = sender.date
        startDate.text = dateFormatter.stringFromDate(sender.date)
        
    }
    

   
    /**
     * Method call do action for done in datePicker
     */
 
    
    func handleEndDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gDateFormat
        endDatevalid = sender.date
        endDate.text = dateFormatter.stringFromDate(sender.date)
    }


    func doneButton(sender:UIButton)
    {
        startDate.resignFirstResponder() // To resign the inputView on clicking done.
        endDate.resignFirstResponder()
        // To resign the inputView on clicking done.
    }
    
    
    @IBAction func startTimePickerChange(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gTimeFormat
        startTimeValid = sender.date
        var strDate = dateFormatter.stringFromDate(sender.date)
        startTime.text = strDate

    }
    
    @IBAction func endTimePickerChange(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gTimeFormat
        endTimeValid = sender.date
        var strDate = dateFormatter.stringFromDate(sender.date)
       
        endTime.text = strDate
        

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iOStimeZones.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
//       
//        let titleData = iOStimeZones[row]
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!])
       // pickerView.sizeToFit()
        return iOStimeZones[row]
    }

    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
         txtTimeZone.text = iOStimeZones[row]
       
        
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
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrolview.contentSize = CGSizeMake(self.view.bounds.width, self.btnPostEvent.frame.origin.y + 500)
        scrolview.scrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchReqTitle(sender: AnyObject) {
        self.requiredError.hidden = true
    }
    @IBAction func touchReqContent(sender: AnyObject) {
        self.requiredError.hidden = true

    }
    @IBAction func touchReqTag(sender: AnyObject) {
        self.requiredError.hidden = true

    }
    @IBAction func btnPostEvent(sender: UIButton) {
        
        //dateFormatter.dateFormat = "yyyy-MM-dd"
       // var stratDateValidate = dateFormatter.dateFromString(startDate.text!)

       // var currentDateValidate = dateFormatter.stringFromDate(currentDateCheck)
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a zzz"
        var startDateTimeMerge  = startDate.text! + " " + startTime.text!
        startDateAndTime = dateFormatter.dateFromString(startDateTimeMerge)!
        
        var endDateTimeMerge  = endDate.text! + " " + endTime.text!
        endDateAndTime = dateFormatter.dateFromString(endDateTimeMerge)!
        
        
        if(txtTitle.text == "") {
            self.requiredError.hidden = false
             self.requiredError.text = "Required Title"
        }
      
//      else if (txtTags.text == "") {
//            self.requiredError.hidden = false
//            self.requiredError.text = "Required Tags"
//        }
        else if (txtContents.text == "") {
            self.requiredError.hidden = false
            self.requiredError.text = "Required Contests"
        }
//        else if (stratDateValidate!.compare(currentDateValidate) == NSComparisonResult.OrderedSame) {
//            print("Same dates")
//        }
            
        else if (startDateAndTime.compare(currentDate) == NSComparisonResult.OrderedAscending) {
            // print("Date1 is Later than Date2")
            self.requiredError.hidden = false
            self.requiredError.text = "Invalid start Date and time"
        }
       else if (startDateAndTime.timeIntervalSinceReferenceDate > endDateAndTime.timeIntervalSinceReferenceDate) {
            // print("Date1 is Later than Date2")
             self.requiredError.hidden = false
            self.requiredError.text = "Invalid End Date and time"
        }
//        else if startTimeValid.earlierDate(endTimeValid){
//            self.requiredError.hidden = false
//            self.requiredError.text = "Invalid End Time"
//        }
//       else if (startTimeValid.compare(endTimeValid) == NSComparisonResult.OrderedDescending) {
//            self.requiredError.hidden = false
//            self.requiredError.text = "Invalid End Time"
//        }

        else
        {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            if(isEdit){
                testfacade.doTask(self,action: DelphosAction.CREATE_EVENT)

            }
            else{
            
                testfacade.doTask(self,action: DelphosAction.CREATE_EVENT)
            }
        }
        
    }
    

}
