

//
//  DelphosUITests.swift
//  DelphosUITests
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import XCTest

class DelphosUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        //let elementsQuery = app.scrollViews.otherElements
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("jith87@gmail.com")
        
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("ontojith")
        
        XCUIApplication().scrollViews.otherElements.buttons["SIGNIN"].tap()
        
        
        XCUIApplication().buttons["Approval"].tap()
        
        let trackInfoLabel = app.staticTexts["Approval"]
        XCTAssertEqual(trackInfoLabel.exists, true)

        
    }
    func testExamplereg() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        XCUIApplication().scrollViews.otherElements.buttons["REGISTER"].tap()
        
        //let elementsQuery = elementsQuery2
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        nameTextField.typeText("demoa")
        
        let emailTextField = app.textFields["Email "]
        
        emailTextField.tap()
        emailTextField.typeText("demomail5@gmail.com")
        
        let paswordsecureTextFields = app.secureTextFields["Password"]
        paswordsecureTextFields.tap()
        
        paswordsecureTextFields.typeText("ontojith")
        
        let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.typeText("ontojith")
        
        app.buttons["Speaker"].tap()
        
        app.buttons["Register"].tap()
        
        
    }
    func testCreateEvent(){
        
        let app = XCUIApplication()
       // let elementsQuery = app.scrollViews.otherElements
        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("jith87@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("ontojith")
        app.buttons["SIGNIN"].tap()
        app.buttons["Create Event"].tap()
        
        //let app = XCUIApplication()
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("demo utest3")
        
        let contentTextField = app.textFields["Contents"]
        
        
        contentTextField.tap()
        contentTextField.typeText("uitest")
        XCUIApplication().buttons["Post Event"].tap()
        
        
        
        
        
    }
    func testProfileEdit(){
    
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let usernameTextField = elementsQuery.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("jith87@gmail.com")
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("ontojith")
        XCUIApplication().scrollViews.otherElements.buttons["SIGNIN"].tap()
        
        app.navigationBars["School-Business"].buttons["menu btn"].tap()
        app.tables.staticTexts["Profile"].tap()
       
         XCUIApplication().scrollViews.otherElements.buttons["EDIT PROFILE"].tap()
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let publicProfileElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Public Profile")
        
        let textField = publicProfileElementsQuery.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("test")
        
       
        
        let textField2 = publicProfileElementsQuery.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("text2")
        
        let textField3 = publicProfileElementsQuery.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.typeText("5")
        
        
        
        let textField4 = publicProfileElementsQuery.children(matching: .textField).element(boundBy: 3)
        textField4.tap()
        textField4.typeText("test")
        
       
        
        //let scrollViewsQuery = XCUIApplication().scrollViews
        scrollViewsQuery.otherElements.buttons["SAVE PROFILE"].tap()
        //scrollViewsQuery.otherElements.containing(.staticText, identifier:"Public Profile").element.tap()
        
        
        
      // let app = XCUIApplication()
        
        
       

        
    }
    
    func testAccountEdit(){
        
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let usernameTextField = elementsQuery.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("jith87@gmail.com")
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("ontojith")
        XCUIApplication().scrollViews.otherElements.buttons["SIGNIN"].tap()
        
        app.navigationBars["School-Business"].buttons["menu btn"].tap()
        app.tables.staticTexts["Profile"].tap()
        
        
      //  let elementsQuery = XCUIApplication().scrollViews.otherElements
        elementsQuery.buttons["EDIT ACCOUNT"].tap()
        elementsQuery.buttons["Speaker"].tap()
        
        let newPasswordSecureTextField = XCUIApplication().scrollViews.otherElements.secureTextFields["New Password"]
        newPasswordSecureTextField.tap()
        newPasswordSecureTextField.typeText("ontojith1")
        
        let confirmPasswordSecureTextField = XCUIApplication().scrollViews.otherElements.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.typeText("ontojith1")
        
       // let elementsQuery = XCUIApplication().scrollViews.otherElements
        let currentPasswordSecureTextField = elementsQuery.secureTextFields["Current Password"]
        currentPasswordSecureTextField.tap()
        currentPasswordSecureTextField.typeText("ontojith")
        elementsQuery.buttons["SAVE ACCOUNT"].tap()
        
        
    }
    func testSetting(){
    
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let usernameTextField = elementsQuery.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("jith87@gmail.com")
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("ontojith")
        XCUIApplication().scrollViews.otherElements.buttons["SIGNIN"].tap()
        
        app.navigationBars["School-Business"].buttons["menu btn"].tap()
        app.tables.staticTexts["Settings"].tap()
        
        //let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
       
        let eventUpdatesElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Event Updates")
        
        let switch2 = eventUpdatesElementsQuery.children(matching: .switch).matching(identifier: "1").element(boundBy: 0)
        switch2.tap()
        
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Event Updates").element.tap()
        switch2.tap()
        
        //let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.switches["1"].tap()
        
        let saveSettingsButton = app.buttons["SAVE SETTINGS"]
        saveSettingsButton.tap()
        
        let okButton = app.alerts.buttons["Ok"]
        okButton.tap()
        
        let switch3 = eventUpdatesElementsQuery.children(matching: .switch).matching(identifier: "0").element(boundBy: 0)
        switch3.tap()
        switch3.tap()
        elementsQuery.switches["0"].tap()
        saveSettingsButton.tap()
        okButton.tap()
        
        
        
    }
    func testEditEvent(){
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let usernameTextField = elementsQuery.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("jith87@gmail.com")
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("ontojith")
        XCUIApplication().scrollViews.otherElements.buttons["SIGNIN"].tap()
        
        
        //let app = XCUIApplication()
    app.tables.staticTexts["2017-05-04  8:00 PM EDT"].tap()
        app.scrollViews.otherElements.buttons["Edit Event"].tap()
        
        
        app.textFields["Title"].tap()
        //let app = XCUIApplication()
        app.textFields["Title"].typeText("  1")
        
        let contentsTextField = app.textFields["Contents"]
        contentsTextField.tap()
        contentsTextField.typeText("mash up edit ")
       
        let textField = app.scrollViews.children(matching: .textField).element(boundBy: 4)
       
        
        textField.tap()
     
        let datePickersQuery = app.datePickers
        let aprilPickerWheel = datePickersQuery.pickerWheels["April"]
        aprilPickerWheel.press(forDuration: 1.3);
        aprilPickerWheel.swipeUp()
       
        datePickersQuery.pickerWheels["14"].swipeUp()
        datePickersQuery.pickerWheels["2017"].press(forDuration: 1.0);
        app.buttons["Done"].tap()

        
        
        
        
        //let app = XCUIApplication()
        let textField2 = app.scrollViews.children(matching: .textField).element(boundBy: 6)
         textField2.tap()
        aprilPickerWheel.press(forDuration: 1.3);
        aprilPickerWheel.swipeUp()
        
        datePickersQuery.pickerWheels["14"].swipeUp()
        datePickersQuery.pickerWheels["2017"].swipeUp()
        
        app.buttons["Done"].tap()
       
        
        
        app.buttons["Update Event"].tap()
        
        
        
    
    
    }
    func testSearch(){
        
        let app = XCUIApplication()
        let schoolBusinessNavigationBar = app.navigationBars["School-Business"]
//
        let searchButton = schoolBusinessNavigationBar.buttons["Search"]
        searchButton.tap()
//        
        app.buttons["Events"].tap()
        app.textFields["Search"].tap()
        
       
        app.textFields["Search"].typeText("test")
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()

//        let app = XCUIApplication()
//               schoolBusinessNavigationBar.buttons["menu btn"].tap()
//        app.statusBars.otherElements["-100% battery power"].tap()
//        
//       
         searchButton.tap()
        app.buttons["Schools"].tap()
        //XCUIApplication().buttons["Schools"].tap()
        
        let searchTextField = XCUIApplication().textFields["Search"]
        searchTextField.tap()
        searchTextField.typeText("delphos")
        
        
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()

    
        
   // user search

        
        searchButton.tap()
        app.buttons["Users"].tap()
        searchTextField.tap()
        searchTextField.typeText("babu")
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()

        
     // zip code search
        searchButton.tap()
        let zipcodeTextField = XCUIApplication().textFields["Zipcode"]
        zipcodeTextField.tap()
        zipcodeTextField.typeText("45833")
        
        //let app = XCUIApplication()
       let radiusTextField = app.textFields["Radius"]
        radiusTextField.tap()
        radiusTextField.typeText("10")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()
//
        
        
        // event zip code search 
        
        searchButton.tap()
        app.buttons["Events"].tap()
        
        searchTextField.tap()
        searchTextField.typeText("test")
        
        //app.buttons["Schools"].tap()
        
       // let zipcodeTextField = XCUIApplication().textFields["Zipcode"]
        zipcodeTextField.tap()
        zipcodeTextField.typeText("45833")
        
        //let app = XCUIApplication()
     //  let radiusTextField = app.textFields["Radius"]
        radiusTextField.tap()
        radiusTextField.typeText("10")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()
        
        
        // school zip code and raduis search
        
        searchButton.tap()
        app.buttons["Schools"].tap()
        
        searchTextField.tap()
        searchTextField.typeText("delphos")
        
        //app.buttons["Schools"].tap()
        
        //let zipcodeTextField = XCUIApplication().textFields["Zipcode"]
        zipcodeTextField.tap()
        zipcodeTextField.typeText("45833")
        
        //let app = XCUIApplication()
        //let radiusTextField = app.textFields["Radius"]
        radiusTextField.tap()
        radiusTextField.typeText("10")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()
        
        
    }
    func testSearchUserAndSentMsg(){
        
        
        
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        let usernameTextField = elementsQuery.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("jith87@gmail.com")
        
        usernameTextField.tap()
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        passwordSecureTextField.tap()
        
        passwordSecureTextField.typeText("ontojith")
        elementsQuery.buttons["SIGNIN"].tap()
        
        
        let searchButton = XCUIApplication().navigationBars["School-Business"].buttons["Search"]
        searchButton.tap()
        //searchButton.tap()
        
        let app = XCUIApplication()
        app.buttons["Users"].tap()
        XCUIApplication().textFields["Search"].tap()
        
        app.textFields["Search"].typeText("babu")
        
        
        
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element.children(matching: .other).element.children(matching: .other).element.buttons["Search"].tap()
        element.tables.children(matching: .cell).element(boundBy: 1).staticTexts["babu"].tap()
        app.buttons["Contact User"].tap()
        
       // let app = XCUIApplication()
        let textField = app.scrollViews.children(matching: .textField).element
        textField.tap()
        textField.typeText("hai")
        app.buttons["Send message"].tap()
        app.alerts.buttons["Ok"].tap()
        
        
        
    }
    
    
   
}
