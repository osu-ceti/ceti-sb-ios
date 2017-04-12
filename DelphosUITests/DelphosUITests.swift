

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
        emailTextField.typeText("demomail2@gmail.com")
        
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
        titleTextField.typeText("demo utest2")
        
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
}
