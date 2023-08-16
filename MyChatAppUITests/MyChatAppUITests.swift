//
//  MyChatAppUITests.swift
//  MyChatAppUITests
//
//  Created by mac on 15/07/2023.
//

import XCTest

final class MyChatAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let element = app/*@START_MENU_TOKEN@*/.otherElements["MyChatApp"].scrollViews/*[[".windows[\"SBSwitcherWindow:Main\"]",".otherElements[\"AppSwitcherContentView\"]",".otherElements[\"MyChatApp\"].scrollViews",".otherElements[\"card:com.masterk.MyChatApp:sceneID:com.masterk.MyChatApp-default\"].scrollViews",".scrollViews"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,4],[-1,3],[-1,2]]],[1]]@END_MENU_TOKEN@*/.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        let textfield = app/*@START_MENU_TOKEN@*/.textFields["Email Address..."]/*[[".scrollViews.textFields[\"Email Address...\"]",".textFields[\"Email Address...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(textfield.exists)
            textfield.tap()
        
        let passwordSecureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["Password..."]/*[[".scrollViews.secureTextFields[\"Password...\"]",".secureTextFields[\"Password...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        passwordSecureTextField.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Log In"]/*[[".scrollViews.buttons[\"Log In\"]",".buttons[\"Log In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
