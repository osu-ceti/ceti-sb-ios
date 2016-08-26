//
//  CreateEventController.swift
//  Delphos
//
//  Created by Babu on 5/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

class CreateEventController: NavController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
   
    @IBOutlet var txtTimeZoneSelect: UITextField!
   
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
    
    let checkCharacter = NSCharacterSet.letterCharacterSet()
    
    
   // @IBOutlet var txtStartTimeTouch: UITextField!
  
    @IBOutlet var txtStartTime: UITextField!
    @IBOutlet var txtEndTime: UITextField!
  
    var datePickerView = UIDatePicker()
    var timePickerView = UIDatePicker()
    var endTimePickerView = UIDatePicker()
    
    func getCurrentDate() -> NSDate{
        return NSDate()
    }
    var currentDate = NSDate()

    var dateFormatter       = NSDateFormatter()
    var endDatevalid        = NSDate()
    var startDatevalid      = NSDate()
    var startTimeValid      = NSDate()
    var endTimeValid        = NSDate()
    var startDateAndTime    = NSDate()
    var endDateAndTime      = NSDate()
    
    var isEdit = false
    var eventId = 0

   // let dataTimeZone = NSTimeZone.knownTimeZoneNames()
    //var timeAbb = iOStimeZones?.abbreviation
    let iOStimeZones = ["Eastern Time (US & Canada)"]

    @IBOutlet var scrolview: UIScrollView!
    
    var newTimeZonePicker = UIPickerView()
   
    @IBOutlet weak var timeZonePicker: UIPickerView!
   
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = true
        setNavBar1(self.view.frame.size.width,height: 0)
        //setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewController = self
        self.requiredError.hidden = true
        settingSearch = true
      
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
        
        self.view.backgroundColor = bgColor
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, txtTitle.frame.height - 1, txtTitle.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
        txtTitle.borderStyle = UITextBorderStyle.None
        txtTitle.layer.addSublayer(bottomLine)
        
        let txtContentsLine = CALayer()
        txtContentsLine.frame = CGRectMake(0.0, txtContents.frame.height - 1, txtContents.frame.width, 1.0)
        txtContentsLine.backgroundColor = UIColor.blackColor().CGColor
        txtContents.borderStyle = UITextBorderStyle.None
        txtContents.layer.addSublayer(txtContentsLine)
        
        let txtTagsLine = CALayer()
        txtTagsLine.frame = CGRectMake(0.0, txtTags.frame.height - 1, txtTags.frame.width, 1.0)
        txtTagsLine.backgroundColor = UIColor.blackColor().CGColor
        txtTags.borderStyle = UITextBorderStyle.None
        txtTags.layer.addSublayer(txtTagsLine)
        
        let txtTimeZoneSelectLine = CALayer()
        txtTimeZoneSelectLine.frame = CGRectMake(0.0, txtTimeZoneSelect.frame.height - 1, txtTimeZoneSelect.frame.width, 1.0)
        txtTimeZoneSelectLine.backgroundColor = UIColor.blackColor().CGColor
        txtTimeZoneSelect.borderStyle = UITextBorderStyle.None
        txtTimeZoneSelect.layer.addSublayer(txtTimeZoneSelectLine)
        
        let startDateLine = CALayer()
        startDateLine.frame = CGRectMake(0.0, startDate.frame.height - 1, startDate.frame.width, 1.0)
        startDateLine.backgroundColor = UIColor.blackColor().CGColor
        startDate.borderStyle = UITextBorderStyle.None
        startDate.layer.addSublayer(startDateLine)
        
        
        let txtStartTimeLine = CALayer()
        txtStartTimeLine.frame = CGRectMake(0.0, txtStartTime.frame.height - 1, txtStartTime.frame.width, 1.0)
        txtStartTimeLine.backgroundColor = UIColor.blackColor().CGColor
        txtStartTime.borderStyle = UITextBorderStyle.None
        txtStartTime.layer.addSublayer(txtStartTimeLine)
        
        let endDateLine = CALayer()
        endDateLine.frame = CGRectMake(0.0, endDate.frame.height - 1, endDate.frame.width, 1.0)
        endDateLine.backgroundColor = UIColor.blackColor().CGColor
        endDate.borderStyle = UITextBorderStyle.None
        endDate.layer.addSublayer(endDateLine)
        
        
        let txtEndTimeLine = CALayer()
        txtEndTimeLine.frame = CGRectMake(0.0, txtEndTime.frame.height - 1, txtEndTime.frame.width, 1.0)
        txtEndTimeLine.backgroundColor = UIColor.blackColor().CGColor
        txtEndTime.borderStyle = UITextBorderStyle.None
        txtEndTime.layer.addSublayer(txtEndTimeLine)

        txtTitle.backgroundColor = bgColor //UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        txtContents.backgroundColor = txtTitle.backgroundColor
        txtTags.backgroundColor = txtTitle.backgroundColor
        startDate.backgroundColor = txtTitle.backgroundColor
        endDate.backgroundColor = txtTitle.backgroundColor
        //button
      
        
        
        //end bg design
        //start.frame = CGRectMake(10, 30, 30, 20)
        let startTimeSet = currentDate.dateByAddingTimeInterval(60*60);
        let endTimeSet = currentDate.dateByAddingTimeInterval(60*120);
        
       // let checkCurrentDate = currentDate.dateByAddingTimeInterval(-1*24*60*60);
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gTimeFormat
       
        startTime.text = dateFormatter.stringFromDate(startTimeSet)
        endTime.text = dateFormatter.stringFromDate(endTimeSet)
       
        //Set the display Labels
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtStartTime.text = dateFormatter.stringFromDate(startTimeSet)
        txtEndTime.text = dateFormatter.stringFromDate(endTimeSet)
        
        
        startDatevalid = startTimeSet
        endDatevalid = endTimeSet
         
        self.startTimePicker.setDate(startTimeSet, animated: false)
        self.endTimePicker.setDate(endTimeSet, animated: false)
        
        txtTimeZone.text = "Eastern Time (US & Canada)"
        txtTimeZoneSelect.text = "Eastern Time (US & Canada)"
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
                
                //self.startTimePicker.date = eventStartDate!
                 //self.txtStartTime.text = gObjShowEventBean.event_start!
               
                dateFormatter.dateFormat = gTimeFormat
                self.startTime.text = dateFormatter.stringFromDate(eventStartDate!)
                
                dateFormatter.dateFormat = gTimeWithoutZoneFormat
                self.txtStartTime.text =  dateFormatter.stringFromDate(eventStartDate!)
                
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

                dateFormatter.dateFormat = gTimeWithoutZoneFormat
                self.txtEndTime.text = dateFormatter.stringFromDate(eventEndDate!)
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
        
        dateFormatter.dateFormat = gDateFormat
        let dtStartDate  = startDate.text!
        if(dtStartDate != ""){
            
            datePickerView.date = dateFormatter.dateFromString(dtStartDate)!
        }
        
        
        
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
        
        dateFormatter.dateFormat = gDateFormat
        let dtEndDate  = endDate.text!
        if(dtEndDate != ""){
            datePickerView.date = dateFormatter.dateFromString(dtEndDate)!
        }
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
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtStartTime.text = dateFormatter.stringFromDate(sender.date)
        
    }
    

   
    /**
     * Method call do action for done in datePicker
     */
 
    
    func handleEndDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gDateFormat
        endDatevalid = sender.date
        endDate.text = dateFormatter.stringFromDate(sender.date)

        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtEndTime.text = dateFormatter.stringFromDate(sender.date)

    }


    func doneButton(sender:UIButton)
    {
        startDate.resignFirstResponder() // To resign the inputView on clicking done.
        endDate.resignFirstResponder()
        txtTimeZoneSelect.resignFirstResponder()
        txtStartTime.resignFirstResponder()
        txtEndTime.resignFirstResponder()
        
        // To resign the inputView on clicking done.
    }
    
    
    @IBAction func startTimeClick(sender: UITextField) {
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            timePickerView = UIDatePicker(frame: CGRectMake(inputView.frame.origin.x + 250 , 40, 0, 0))
        }
        else {
            timePickerView = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        }
        
        
        timePickerView.datePickerMode = UIDatePickerMode.Time
        
        dateFormatter.dateFormat = gTimeFormat
        let startTimePickerValue  = txtStartTime.text!
        if(startTimePickerValue != ""){
           
            timePickerView.date = startDatevalid
        }
        inputView.addSubview(timePickerView)
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        timePickerView.addTarget(self, action: Selector("handleStartTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleStartTimePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
       dateFormatter.dateFormat = gTimeFormat
        startDatevalid = sender.date
        
        startTime.text = dateFormatter.stringFromDate(sender.date)
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtStartTime.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func endTimePicker(sender: UITextField) {
       
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            endTimePickerView = UIDatePicker(frame: CGRectMake(inputView.frame.origin.x + 250 , 40, 0, 0))
        }
        else {
            endTimePickerView = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        }
        
        
        endTimePickerView.datePickerMode = UIDatePickerMode.Time
        
        dateFormatter.dateFormat = gTimeFormat
        let endTimePickerValue  = txtEndTime.text!
        if(endTimePickerValue != ""){
            endTimePickerView.date = endDatevalid
        }
        inputView.addSubview(endTimePickerView)
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        endTimePickerView.addTarget(self, action: Selector("handleEndTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleEndTimePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = gTimeFormat
        endDatevalid = sender.date
        
        
        endTime.text = dateFormatter.stringFromDate(sender.date)
        
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtEndTime.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func startTimePickerChange(sender: AnyObject) {
    
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = gTimeFormat
//        startTimeValid = sender.date
//        var strDate = dateFormatter.stringFromDate(sender.date)
//        startTime.text = strDate

    }
    
    @IBAction func endTimePickerChange(sender: AnyObject) {
   
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = gTimeFormat
//        endTimeValid = sender.date
//        var strDate = dateFormatter.stringFromDate(sender.date)
//       
//        endTime.text = strDate
        

    }
    
    
    
    @IBAction func touchTimeZone(sender: UITextField) {
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            newTimeZonePicker = UIPickerView(frame: CGRectMake(inputView.frame.origin.x + 250 , 40, 0, 0))
        }
        else {
            newTimeZonePicker = UIPickerView(frame: CGRectMake(0, 40, 0, 0))
        }
       
        newTimeZonePicker.dataSource = self
        newTimeZonePicker.delegate = self
       
        
        //datePickerView.datePickerMode = UIDatePickerMode.Date
        
        inputView.addSubview(newTimeZonePicker)
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
       
//        let txtTime = UILabel(frame: CGRectMake((self.view.frame.size.width/6), 20, 250, 100))
//        txtTime.text = "Eastern Time (US & Canada)"
//        inputView.addSubview(txtTime)
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
       // datePickerView.addTarget(self, action: Selector("handleTimeZonePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
//    func handleTimeZonePicker(sender: UIPickerView) {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = gDateFormat
//        endDatevalid = sender.date
//        endDate.text = dateFormatter.stringFromDate(sender.date)
//    }

    
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
        txtTimeZoneSelect.text = iOStimeZones[row]
       
        
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
        
        scrolview.contentSize = CGSizeMake(self.view.bounds.width, self.btnPostEvent.frame.origin.y + 300)
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
//    @IBAction func touchReqTag(sender: AnyObject) {
//        self.requiredError.hidden = true
//
//    }
    @IBAction func btnPostEvent(sender: UIButton) {
        
        //dateFormatter.dateFormat = "yyyy-MM-dd"
       // var stratDateValidate = dateFormatter.dateFromString(startDate.text!)

       // var currentDateValidate = dateFormatter.stringFromDate(currentDateCheck)
        
        dateFormatter.dateFormat = gDateTimeFormat
        var startDateTimeMerge  = startDate.text! + " " + startTime.text!
        startDateAndTime = dateFormatter.dateFromString(startDateTimeMerge)!
        
        var endDateTimeMerge  = endDate.text! + " " + endTime.text!
        endDateAndTime = dateFormatter.dateFromString(endDateTimeMerge)!
        
       var trimmedTitle = txtTitle.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
       var trimmedContents = txtContents.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(trimmedTitle == "") {
            self.requiredError.hidden = false
             self.requiredError.text = "Required Title"
        }
      
//      else if (txtTags.text == "") {
//            self.requiredError.hidden = false
//            self.requiredError.text = "Required Tags"
//        }
        else if (trimmedContents == "") {
            self.requiredError.hidden = false
            self.requiredError.text = "Required Contents"
        }
//        else if (stratDateValidate!.compare(currentDateValidate) == NSComparisonResult.OrderedSame) {
//            print("Same dates")
//        }
            
        else if (startDateAndTime.compare(currentDate) == NSComparisonResult.OrderedAscending) {
            // print("Date1 is Later than Date2")
            self.requiredError.hidden = false
            self.requiredError.text = "Invalid Start date and time value. Please select a value at least 1 hour from now."
        }
       else if (startDateAndTime.timeIntervalSinceReferenceDate > endDateAndTime.timeIntervalSinceReferenceDate) {
            // print("Date1 is Later than Date2")
             self.requiredError.hidden = false
            self.requiredError.text = "Invalid End Date And Time"
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
            txtTitle.text = trimmedTitle
            txtContents.text! = trimmedContents
            showOverlay(self.view)
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
