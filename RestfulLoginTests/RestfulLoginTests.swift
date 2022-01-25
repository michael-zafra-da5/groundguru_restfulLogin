//
//  RestfulLoginTests.swift
//  RestfulLoginTests
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import XCTest
@testable import RestfulLogin

class RestfulLoginTests: XCTestCase {
    
    private var message: Message? = nil
    override func setUp() {
        super.setUp()
//        message = Message(message: "Testing", sender: "sample@gmail.com")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testMessageModel_canCreateInstance() throws {
        XCTAssertNotNil(message)
    }
    
    func testMessageModel_cantCreateInstance() throws {
        XCTAssertNil(message)
    }
    
    func testMessageModel_SuccesInstance() throws {
        message = Message(message: "Testing", sender: "sample@gmail.com")
        XCTAssertEqual(message?.message, "Testing", "Text field value is not correct")
        XCTAssertEqual(message?.sender, "sample@gmail.com", "Text field value is not correct")
    }
    
    func testMessageModel_FailInstance() throws {
        message = Message(message: "Testing", sender: "sample@gmail.com")
        XCTAssertEqual(message?.message, "fail", "Text field value is not correct")
        XCTAssertEqual(message?.sender, "fail", "Text field value is not correct")
    }
    
    func testMessageModel() throws {
        XCTAssertNil(message) //Success
        XCTAssertNotNil(message) //Fail
        message = Message(message: "Testing", sender: "sample@gmail.com")
        XCTAssertNil(message)  //Fail
        XCTAssertNotNil(message) //Success
        
        XCTAssertEqual(message?.message, "Testing", "Text field value is not correct")    //Success
        XCTAssertEqual(message?.sender, "sample@gmail.com", "Text field value is not correct")   //Success
        
        XCTAssertEqual(message?.message, "fail", "Text field value is not correct")  //Fail
        XCTAssertEqual(message?.sender, "fail", "Text field value is not correct")  //Fail
    }
}
