//
//  CreateEventController.swift
//  Delphos
//
//  Created by Babu on 5/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

class CreateEventController: UIViewController,UINavigationBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
       @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContents: UITextField!
    @IBOutlet weak var txtTags: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var stratTimePicker: UIDatePicker!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var validateTitle: UILabel!
    @IBOutlet weak var txtTimeZone: UITextField!
    @IBOutlet weak var btnPostEvent: UIButton!
    
    @IBOutlet weak var requiredError: UILabel!
    var datePickerView = UIDatePicker()
    
    var dateFormatter = NSDateFormatter()
    var navigationBar: UINavigationBar = UINavigationBar()
    var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    var searchBarItem = UIBarButtonItem()
    var searchButtonItem = UIBarButtonItem()
    var isEdit = false
    var eventId = 0

    //let dataTimeZone = NSTimeZone.knownTimeZoneNames()
   // var timeAbb = iOStimeZones?.abbreviation
    var iOStimeZones = ["Eastern Time (US & Canada)"]
    
    @IBOutlet weak var scrolview: UIScrollView!
    @IBOutlet weak var timeZonePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requiredError.hidden = true
       // txtTitle = UITextField(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 25))
        //self.view.addSubview(txtTitle)
        // Create the navigation bar
        navigationBar = UINavigationBar(frame: CGRectMake(0, 17, self.view.frame.size.width, 44))
        navigationBar.backgroundColor = UIColor(hue: 0.2889, saturation: 0, brightness: 0.95, alpha: 1.0)
        navigationBar.delegate = self;
        navigationBar.layer.shadowOpacity = 4
        navigationBar.layer.shadowRadius  = 2
        navigationBar.layer.shadowOffset = CGSizeMake(2, 2);
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "School-Business"
        searchButtonItem = UIBarButtonItem(customView:searchBar)
        // Create left and right button for navigation item
        
        //searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "btnSearchClick:")
        
        // Create two buttons for the navigation item
        
        let backimage = UIImage(contentsOfFile:"backarrow")
        searchButton = UIBarButtonItem(title : "Back",style: UIBarButtonItemStyle.Plain, target: nil, action: "back:")
        navigationItem.leftBarButtonItem = searchButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
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
        //end bg design
        //start.frame = CGRectMake(10, 30, 30, 20)
        var myObject = NSDate()
        let futureDate = myObject.dateByAddingTimeInterval(60*60);
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH-mm-ss-a"
        startTime.text = dateFormatter.stringFromDate(myObject)
        endTime.text = dateFormatter.stringFromDate(futureDate)
        txtTimeZone.text = "Eastern Time (US & Canada)"
        self.startTime.hidden = true
        self.endTime.hidden = true
        self.txtTimeZone.hidden = true
        var currentDtae = NSDate()
         var CurrentDateFormat = NSDateFormatter()
        CurrentDateFormat.dateFormat = "yyyy-mm-dd"
        self.startDate.text = CurrentDateFormat.stringFromDate(currentDtae)
        self.endDate.text = CurrentDateFormat.stringFromDate(currentDtae)
        
        if(isEdit){
            //Page is being edited 
            self.txtTitle.text = gObjShowEventBean.title
            self.txtContents.text = gObjShowEventBean.content
            self.startDate.text = gObjShowEventBean.event_start
            self.endDate.text = gObjShowEventBean.event_end
            self.eventId = gObjShowEventBean.id
//          self.startTime.text = gObjShowEventBean.user_name
//          self.endTime.text = gObjShowEventBean.content
//          self.txtTags.text = gObjShowEventBean.event_

            btnPostEvent.setTitle("Update Event", forState: .Normal)
            

        }
    }
    func back(sender: UIBarButtonItem){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("loginId") as! ViewController
        self.presentViewController(nextViewController,animated:true,completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
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
        endDate.resignFirstResponder()
        // To resign the inputView on clicking done.
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iOStimeZones.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
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
        
        scrolview.contentSize = CGSizeMake(self.view.bounds.width, self.btnPostEvent.frame.origin.y + 50)
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
        if(txtTitle.text == "") {
            self.requiredError.hidden = false
             self.requiredError.text = "Required Title"
        }
         else if (txtContents.text == "") {
            self.requiredError.hidden = false
            self.requiredError.text = "Required Contests"
        }
        else if (txtTags.text == "") {
            self.requiredError.hidden = false
            self.requiredError.text = "Required Tags"
        }
        
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