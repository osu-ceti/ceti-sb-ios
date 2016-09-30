//
//  SchoolProfileController.swift
//  Delphos
//
//  Created by Babu on 6/17/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//


import UIKit



class SchoolProfileController:  NavController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet var schoolNameLabel: UILabel!
    
    
    @IBOutlet var labelNoEventFound: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var labelCity: UILabel!
    @IBOutlet var labelState: UILabel!
    @IBOutlet var labelZip: UILabel!
    @IBOutlet var labelPhone: UILabel!
    
    
    
    @IBOutlet var txtAddress: UILabel!
    @IBOutlet var txtCity: UILabel!
    @IBOutlet var txtState: UILabel!
    @IBOutlet var txtZip: UILabel!
    @IBOutlet var txtPhone: UILabel!
    
    @IBOutlet var schoolImage: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    var eventDisplayBean: usersBean!
    var eventBeanArray: [EventBean]! = []
    
    var strSchoolId:String!
    var makeMySchoolName:String!
    var tempBackToViewController:UIViewController!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Adding Navbar
        //        menus = regularMenu
        //        rightViewController.isRegister = false
        //        rightViewController.tableView.reloadData()
        
        self.isBackEnabled = false
        setNavBar(self.view.frame.size.width)
        searchBar.delegate = self
        
        backToController = gObjHomeController
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewController = self
         
        
        self.view.backgroundColor = bgColor
        self.showOverlay(self.view)
        DispatchQueue.global( priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            
            let url = URL(string: AWS_S3 + gObjSchoolImage)
            var data = try? Data(contentsOf: url!)
            if data != nil {
                DispatchQueue.main.async(execute: {
                    self.hideOverlayView()
                    self.schoolImage.image = UIImage(data:data!)
                })
            }
        })
        
        
        if(tempBackToViewController != nil){
            gObjBackTocontroller = tempBackToViewController
            tempBackToViewController = nil
        }
        
         self.tableView.backgroundColor = bgColor
        self.tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.tableFooterView = UIView()
       
        //schoolImage.image = UIImage(named:"gObjSchoolImage")
        schoolNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        labelAddress.font = UIFont.boldSystemFont(ofSize: 15)
        labelCity.font = UIFont.boldSystemFont(ofSize: 15)
        labelState.font = UIFont.boldSystemFont(ofSize: 15)
        labelZip.font = UIFont.boldSystemFont(ofSize: 15)
        labelPhone.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.labelNoEventFound.isHidden = true
        
        self.schoolNameLabel.text = gObjSearchSchoolListBean.name
        
        self.labelAddress.text = "Address:"
        self.labelCity.text =   "City:"
        self.labelState.text = "State:"
        self.labelZip.text = "Zip:"
        self.labelPhone.text = "Phone:"

        self.txtAddress.text = gObjSearchSchoolListBean.address
        self.txtCity.text = gObjSearchSchoolListBean.city
        self.txtState.text = gObjSearchSchoolListBean.state
        self.txtZip.text = gObjSearchSchoolListBean.zip
        self.txtPhone.text = gObjSearchSchoolListBean.phone
        
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if(eventBeanArray!.count > 0){
          
            
            return eventBeanArray!.count
        }
        else{
            return 1
        }
    }
    
    func configureCell(_ cell: UITableViewCell,   indexPath: IndexPath)  {
        
        if(eventBeanArray!.count > 0){
            self.tableView.isHidden = false
            let eventDisplayBean: EventBean! = eventBeanArray[(indexPath as NSIndexPath).row]

            (cell as! SchoolProfileCell).eventTitle!.text = String(eventDisplayBean.event_title)
            (cell as! SchoolProfileCell).eventStartDate!.text = String(eventDisplayBean.event_start)
            (cell as! SchoolProfileCell).eventId!.text =  String(eventDisplayBean.id)
        }
        else{
            
            self.tableView.isHidden = true
            self.labelNoEventFound.isHidden = false
        }
       
        
    }
    
    //function to return dynamic cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolProfileCell", for: indexPath) as? UITableViewCell
        
        configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    //function to respond to row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectCell = tableView.cellForRow(at: indexPath) as! SchoolProfileCell
        print("currentCell", selectCell.eventId.text!)
        
        tempBackToViewController = gObjBackTocontroller
        gObjBackTocontroller = gObjSchoolProfileNavController
        gEventID = Int(selectCell.eventId.text!)
        DispatchQueue.main.async(execute: {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let testfacade = appDelegate.getObjFacade()
            testfacade.doTask(self,action: DelphosAction.show_EVENT)
        })
    }
    

    
    @IBAction func makeMySchoolClick(_ sender: AnyObject) {
        
        if(gObjSearchSchoolListBean != nil){
            if(gObjSearchSchoolListBean.id != nil){
                strSchoolId =  String(gObjSearchSchoolListBean.id)
            }
            if(gObjSearchSchoolListBean.name != nil){
                makeMySchoolName = gObjSearchSchoolListBean.name
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let testfacade = appDelegate.getObjFacade()
        testfacade.doTask(self,action: DelphosAction.show_MAKE_MY_SCHOOL)
        
    }
    
    
    
}

  
