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
    //@IBOutlet weak var txtTags: UITextField!
    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var requiredError: UILabel!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var txtTimeZone: UITextField!
    
    @IBOutlet weak var btnPostEvent: UIButton!
    
    let checkCharacter = CharacterSet.letters
    
    
   // @IBOutlet var txtStartTimeTouch: UITextField!
  
    @IBOutlet var txtStartTime: UITextField!
    @IBOutlet var txtEndTime: UITextField!
  
    var datePickerView = UIDatePicker()
    var timePickerView = UIDatePicker()
    var endTimePickerView = UIDatePicker()
    
    func getCurrentDate() -> Date{
        return Date()
    }
    var currentDate = Date()

    var dateFormatter       = DateFormatter()
    var endDatevalid        = Date()
    var startDatevalid      = Date()
    var startTimeValid      = Date()
    var endTimeValid        = Date()
    var startDateAndTime    = Date()
    var endDateAndTime      = Date()
    
    var isEdit = false
    var eventId = 0
    
//    var startDateTZ = "EST"
//    var endDateTZ = "EST"
    
    var startDateTZ = "EDT"
    var endDateTZ = "EDT"
   // let dataTimeZone = NSTimeZone.knownTimeZoneNames()
    //var timeAbb = iOStimeZones?.abbreviation
    let iOStimeZones = ["Eastern Time (US & Canada)"]

    @IBOutlet var scrolview: UIScrollView!
    
    var newTimeZonePicker = UIPickerView()
   
    @IBOutlet weak var timeZonePicker: UIPickerView!
   
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        self.requiredError.isHidden = true
        settingSearch = true
      
        
        self.view.backgroundColor = bgColor
        txtTitle.delegate = self
        txtContents.delegate = self
        //txtTags.delegate = self
        
        
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtTitle.frame.height - 1, width: txtTitle.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        txtTitle.borderStyle = UITextBorderStyle.none
        txtTitle.layer.addSublayer(bottomLine)
        
        let txtContentsLine = CALayer()
        txtContentsLine.frame = CGRect(x: 0.0, y: txtContents.frame.height - 1, width: txtContents.frame.width, height: 1.0)
        txtContentsLine.backgroundColor = UIColor.black.cgColor
        txtContents.borderStyle = UITextBorderStyle.none
        txtContents.layer.addSublayer(txtContentsLine)
        
//        let txtTagsLine = CALayer()
//        txtTagsLine.frame = CGRect(x: 0.0, y: txtTags.frame.height - 1, width: txtTags.frame.width, height: 1.0)
//        txtTagsLine.backgroundColor = UIColor.black.cgColor
//        txtTags.borderStyle = UITextBorderStyle.none
//        txtTags.layer.addSublayer(txtTagsLine)
        
        let txtTimeZoneSelectLine = CALayer()
        txtTimeZoneSelectLine.frame = CGRect(x: 0.0, y: txtTimeZoneSelect.frame.height - 1, width: txtTimeZoneSelect.frame.width, height: 1.0)
        txtTimeZoneSelectLine.backgroundColor = UIColor.black.cgColor
        txtTimeZoneSelect.borderStyle = UITextBorderStyle.none
        txtTimeZoneSelect.layer.addSublayer(txtTimeZoneSelectLine)
        
        let startDateLine = CALayer()
        startDateLine.frame = CGRect(x: 0.0, y: startDate.frame.height - 1, width: startDate.frame.width, height: 1.0)
        startDateLine.backgroundColor = UIColor.black.cgColor
        startDate.borderStyle = UITextBorderStyle.none
        startDate.layer.addSublayer(startDateLine)
        
        
        let txtStartTimeLine = CALayer()
        txtStartTimeLine.frame = CGRect(x: 0.0, y: txtStartTime.frame.height - 1, width: txtStartTime.frame.width, height: 1.0)
        txtStartTimeLine.backgroundColor = UIColor.black.cgColor
        txtStartTime.borderStyle = UITextBorderStyle.none
        txtStartTime.layer.addSublayer(txtStartTimeLine)
        
        let endDateLine = CALayer()
        endDateLine.frame = CGRect(x: 0.0, y: endDate.frame.height - 1, width: endDate.frame.width, height: 1.0)
        endDateLine.backgroundColor = UIColor.black.cgColor
        endDate.borderStyle = UITextBorderStyle.none
        endDate.layer.addSublayer(endDateLine)
        
        
        let txtEndTimeLine = CALayer()
        txtEndTimeLine.frame = CGRect(x: 0.0, y: txtEndTime.frame.height - 1, width: txtEndTime.frame.width, height: 1.0)
        txtEndTimeLine.backgroundColor = UIColor.black.cgColor
        txtEndTime.borderStyle = UITextBorderStyle.none
        txtEndTime.layer.addSublayer(txtEndTimeLine)

        txtTitle.backgroundColor = bgColor //UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0) /* #f2f2f2 */
        txtContents.backgroundColor = txtTitle.backgroundColor
       // txtTags.backgroundColor = txtTitle.backgroundColor
        startDate.backgroundColor = txtTitle.backgroundColor
        endDate.backgroundColor = txtTitle.backgroundColor
        //button
      
        
        let startTimeSet = currentDate.addingTimeInterval(60*60);
        let endTimeSet = currentDate.addingTimeInterval(60*120);
        dateFormatter.dateFormat = gDateFormat
        //start.frame = CGRectMake(10, 30, 30, 20)
        dateFormatter.timeZone = TimeZone(abbreviation: getTimeZone(from: dateFormatter.string(from: startTimeSet)))
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        
       // let checkCurrentDate = currentDate.dateByAddingTimeInterval(-1*24*60*60);
        
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
       
        startTime.text = dateFormatter.string(from: startTimeSet)
        endTime.text = dateFormatter.string(from: endTimeSet)
       
        //Set the display Labels
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtStartTime.text = dateFormatter.string(from: startTimeSet)
        txtEndTime.text = dateFormatter.string(from: endTimeSet)
        
        
        startDatevalid = startTimeSet
        endDatevalid = endTimeSet
         
        self.startTimePicker.setDate(startTimeSet, animated: false)
        self.endTimePicker.setDate(endTimeSet, animated: false)
        
        txtTimeZone.text = "Eastern Time (US & Canada)"
        txtTimeZoneSelect.text = "Eastern Time (US & Canada)"
        self.startTime.isHidden = true
        self.endTime.isHidden = true
        self.txtTimeZone.isHidden = true
        
        
        dateFormatter.dateFormat = gDateFormat
        self.startDate.text = dateFormatter.string(from: currentDate)
        self.endDate.text = dateFormatter.string(from: currentDate)
      
        if(isEdit){
            //Page is being edited 
            if(gObjShowEventBean.id != nil){
                self.eventId = gObjShowEventBean.id
            }
            if(gObjShowEventBean.title != nil){
                self.txtTitle.text = gObjShowEventBean.title
            }
            if(gObjShowEventBean.content != nil){
                self.txtContents.text = gObjShowEventBean.content
            }
            
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a '" + getTimeZone(from: gObjShowEventBean.event_start) + "'"
            dateFormatter.timeZone = TimeZone(abbreviation: getTimeZone(from:  gObjShowEventBean.event_start)) 
            
            let eventStartDate =  dateFormatter.date(from: gObjShowEventBean.event_start)
            if  (eventStartDate != nil) {
                //String is already formatted
                
                //Start Date and Time
                
                //self.startTimePicker.date = eventStartDate!
                 //self.txtStartTime.text = gObjShowEventBean.event_start!
               
                dateFormatter.dateFormat = gTimeWithoutZoneFormat
                self.startTime.text = dateFormatter.string(from: eventStartDate!)
                
                dateFormatter.dateFormat = gTimeWithoutZoneFormat
                self.txtStartTime.text =  dateFormatter.string(from: eventStartDate!)
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.startDate.text =  dateFormatter.string(from: eventStartDate!)
                
                startDatevalid = eventStartDate!
                
                
            }
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a '" + getTimeZone(from: gObjShowEventBean.event_end) + "'"

           let eventEndDate =  dateFormatter.date(from: gObjShowEventBean.event_end)
            if  (eventEndDate != nil) {
                //String is already formatted
                
                //Start Date and Time
                
                self.endTimePicker.date = eventEndDate!
                
                dateFormatter.dateFormat = gTimeWithoutZoneFormat
                self.endTime.text = dateFormatter.string(from: eventEndDate!)

                dateFormatter.dateFormat = gTimeWithoutZoneFormat
                self.txtEndTime.text = dateFormatter.string(from: eventEndDate!)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.endDate.text =  dateFormatter.string(from: eventEndDate!)
                
                endDatevalid = eventEndDate!
            }
            
            
                
            
            btnPostEvent.setTitle("Update Event", for: UIControlState())
            
         
        }
    }
    
    @IBAction func StartDateTouch(_ sender: UITextField) {
         
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            datePickerView = UIDatePicker(frame: CGRect(x: inputView.frame.origin.x + 250 , y: 40, width: 0, height: 0))
        }
        else {
            datePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        }
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        dateFormatter.dateFormat = gDateFormat
        let dtStartDate  = startDate.text!
        if(dtStartDate != DelphosStrings.EMPTY_STRING){
            
            datePickerView.date = dateFormatter.date(from: dtStartDate)!
        }
        
        
        
        inputView.addSubview(datePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(CreateEventController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(CreateEventController.handleDatePicker(_:)), for: UIControlEvents.valueChanged)
    }
 
    @IBAction func EndDateTouch(_ sender: UITextField) {
      
   
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            datePickerView = UIDatePicker(frame: CGRect(x: inputView.frame.origin.x + 250 , y: 40, width: 0, height: 0))
        }
        else {
            datePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        }
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        dateFormatter.dateFormat = gDateFormat
        let dtEndDate  = endDate.text!
        if(dtEndDate != DelphosStrings.EMPTY_STRING){
            datePickerView.date = dateFormatter.date(from: dtEndDate)!
        }
        inputView.addSubview(datePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: #selector(CreateEventController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(CreateEventController.handleEndDatePicker(_:)), for: UIControlEvents.valueChanged)
    }
    /**
     * Method call to showing date picker for start date in a correct format
     */
    func handleDatePicker(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        let chosenTime = dateFormatter.string(from: startDatevalid)
        
        dateFormatter.dateFormat = gDateFormat
        startDate.text = dateFormatter.string(from: sender.date)
        startDateTZ = getTimeZone(from: startDate.text!)
        let tempBuiltDate = startDate.text! + " " + chosenTime + " " + startDateTZ
        
        dateFormatter.dateFormat = gDateTimeFormat
        startDatevalid = dateFormatter.date(from: tempBuiltDate)!      
        
        
    }
    

   
    /**
     * Method call do action for done in datePicker
     */
 
    
    func handleEndDatePicker(_ sender: UIDatePicker) {
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        let chosenTime = dateFormatter.string(from: endDatevalid)
        
        dateFormatter.dateFormat = gDateFormat
        endDate.text = dateFormatter.string(from: sender.date)
        endDateTZ = getTimeZone(from: endDate.text!)
        let tempBuiltDate = endDate.text! + " " + chosenTime + " " + endDateTZ
        
        dateFormatter.dateFormat = gDateTimeFormat
        endDatevalid = dateFormatter.date(from: tempBuiltDate)!
        
        

    }


    func doneButton(_ sender:UIButton)
    {
        startDate.resignFirstResponder() // To resign the inputView on clicking done.
        endDate.resignFirstResponder()
        txtTimeZoneSelect.resignFirstResponder()
        txtStartTime.resignFirstResponder()
        txtEndTime.resignFirstResponder()
        
        // To resign the inputView on clicking done.
    }
    
    
    @IBAction func startTimeClick(_ sender: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            timePickerView = UIDatePicker(frame: CGRect(x: inputView.frame.origin.x + 250 , y: 40, width: 0, height: 0))
        }
        else {
            timePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        }
        
        timePickerView.locale = Locale(identifier: "en_US_POSIX")
        timePickerView.datePickerMode = UIDatePickerMode.time
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        let startTimePickerValue  = txtStartTime.text!
        if(startTimePickerValue != DelphosStrings.EMPTY_STRING){
           
            timePickerView.date = startDatevalid
            timePickerView.timeZone =  TimeZone(abbreviation: startDateTZ)
        }
        inputView.addSubview(timePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: #selector(CreateEventController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        timePickerView.addTarget(self, action: #selector(CreateEventController.handleStartTimePicker(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleStartTimePicker(_ sender: UIDatePicker) {
        
       dateFormatter.dateFormat = gTimeWithoutZoneFormat
        startDatevalid = sender.date
        
        startTime.text = dateFormatter.string(from: sender.date)
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtStartTime.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func endTimePicker(_ sender: UITextField) {
       
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            endTimePickerView = UIDatePicker(frame: CGRect(x: inputView.frame.origin.x + 250 , y: 40, width: 0, height: 0))
        }
        else {
            endTimePickerView = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        }
        
        endTimePickerView.locale = Locale(identifier: "en_US_POSIX")
        endTimePickerView.datePickerMode = UIDatePickerMode.time
        
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        let endTimePickerValue  = txtEndTime.text!
        if(endTimePickerValue != DelphosStrings.EMPTY_STRING){
            endTimePickerView.date = endDatevalid
            endTimePickerView.timeZone = TimeZone(abbreviation: endDateTZ)
        }
        inputView.addSubview(endTimePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: #selector(CreateEventController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        endTimePickerView.addTarget(self, action: #selector(CreateEventController.handleEndTimePicker(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleEndTimePicker(_ sender: UIDatePicker) {
       
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        endDatevalid = sender.date

        endTime.text = dateFormatter.string(from: sender.date)
        dateFormatter.dateFormat = gTimeWithoutZoneFormat
        txtEndTime.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func startTimePickerChange(_ sender: AnyObject) {
    
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = gTimeFormat
//        startTimeValid = sender.date
//        var strDate = dateFormatter.stringFromDate(sender.date)
//        startTime.text = strDate

    }
    
    @IBAction func endTimePickerChange(_ sender: AnyObject) {
   
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = gTimeFormat
//        endTimeValid = sender.date
//        var strDate = dateFormatter.stringFromDate(sender.date)
//       
//        endTime.text = strDate
        

    }
    
    
    
    @IBAction func touchTimeZone(_ sender: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            newTimeZonePicker = UIPickerView(frame: CGRect(x: inputView.frame.origin.x + 250 , y: 40, width: 0, height: 0))
        }
        else {
            newTimeZonePicker = UIPickerView(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        }
       
        newTimeZonePicker.dataSource = self
        newTimeZonePicker.delegate = self
       
        
        //datePickerView.datePickerMode = UIDatePickerMode.Date
        
        inputView.addSubview(newTimeZonePicker)
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
       
//        let txtTime = UILabel(frame: CGRectMake((self.view.frame.size.width/6), 20, 250, 100))
//        txtTime.text = "Eastern Time (US & Canada)"
//        inputView.addSubview(txtTime)
        
        doneButton.addTarget(self, action: #selector(CreateEventController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
       // datePickerView.addTarget(self, action: Selector("handleTimeZonePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
//    func handleTimeZonePicker(sender: UIPickerView) {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = gDateFormat
//        endDatevalid = sender.date
//        endDate.text = dateFormatter.stringFromDate(sender.date)
//    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iOStimeZones.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
//       
//        let titleData = iOStimeZones[row]
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!])
       // pickerView.sizeToFit()
        return iOStimeZones[row]
    }

    func pickerView(_ pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
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
    
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        scrolview.contentSize = CGSize(width: self.view.bounds.width, height: self.btnPostEvent.frame.origin.y + 300)
        scrolview.isScrollEnabled = true
        //view.addSubview(scrolview)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        @IBAction func touchReqTitle(_ sender: AnyObject) {
   
        self.requiredError.isHidden = true
    }
    @IBAction func touchReqContent(_ sender: AnyObject) {
   
        self.requiredError.isHidden = true

    }
//    @IBAction func touchReqTag(sender: AnyObject) {
//        self.requiredError.hidden = true
//
//    }
    @IBAction func btnPostEvent(_ sender: UIButton) {
        
        //dateFormatter.dateFormat = "yyyy-MM-dd"
       // var stratDateValidate = dateFormatter.dateFromString(startDate.text!)

       // var currentDateValidate = dateFormatter.stringFromDate(currentDateCheck)
        
       // dateFormatter.dateFormat = gDateTimeFormat
        if(!(startTime.text?.contains("AM"))! && !(startTime.text?.contains("PM"))!){
            logger.log(LoggingLevel.INFO, message: "24 hour time detected")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            
        }else
        {
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        }
        var startDateTimeMerge  = startDate.text! + " " + startTime.text!
        startDateAndTime = dateFormatter.date(from: startDateTimeMerge)!
        
        var endDateTimeMerge  = endDate.text! + " " + endTime.text!
        endDateAndTime = dateFormatter.date(from: endDateTimeMerge)!
        
       var trimmedTitle = txtTitle.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
       var trimmedContents = txtContents.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(trimmedTitle == DelphosStrings.EMPTY_STRING) {
            self.requiredError.isHidden = false
             self.requiredError.text = "Required Title"
        }
      
//      else if (txtTags.text == DelphosStrings.EMPTY_STRING) {
//            self.requiredError.hidden = false
//            self.requiredError.text = "Required Tags"
//        }
        else if (trimmedContents == DelphosStrings.EMPTY_STRING) {
            self.requiredError.isHidden = false
            self.requiredError.text = "Required Contents"
        }
//        else if (stratDateValidate!.compare(currentDateValidate) == NSComparisonResult.OrderedSame) {
//            print("Same dates")
//        }
            
        else if (startDateAndTime.compare(currentDate) == ComparisonResult.orderedAscending) {
            // print("Date1 is Later than Date2")
            self.requiredError.isHidden = false
            self.requiredError.text = "Invalid Start date and time value. Please select a value at least 1 hour from now in ET."
        }
       else if (startDateAndTime.timeIntervalSinceReferenceDate >= endDateAndTime.timeIntervalSinceReferenceDate) {
            // print("Date1 is Later than Date2")
             self.requiredError.isHidden = false
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
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            if(isEdit){
                testfacade.doTask(self,action: DelphosAction.create_EVENT)

            }
            else{
            
                testfacade.doTask(self,action: DelphosAction.create_EVENT)
            }
        }
        
    }
    

}
