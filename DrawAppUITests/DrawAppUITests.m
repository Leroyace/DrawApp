//
//  DrawAppUITests.m
//  DrawAppUITests
//
//  Created by Leroy Yu Tse on 23/03/16.
//  Copyright © 2016 Leroy Yu Tse. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DrawAppUITests : XCTestCase

@end

@implementation DrawAppUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"pencil"] tap];
    [app.buttons[@"line"] tap];
    [app.buttons[@"lineWidth3"] tap];
    [app.buttons[@"lineWidth2"] tap];
    [app.buttons[@"lineWidth1"] tap];
    [app.buttons[@"eclipse"] tap];
    [app.buttons[@"square"] tap];
    [app.buttons[@"rectangle"] tap];
    [app.buttons[@"triangle"] tap];
    [app.buttons[@"triangle1"] tap];
    [app.buttons[@"eraser"] tap];
    [app.buttons[@"Undo"] tap];
    
    XCUIElement *saveButton = app.buttons[@"Save"];
    [saveButton tap];
    
    XCUIElementQuery *collectionViewsQuery = app.sheets[@"Select you Choice"].collectionViews;
    [collectionViewsQuery.buttons[@"Save to photo album"] tap];
    [app.alerts[@"Success"].collectionViews.buttons[@"Cancel"] tap];
    [saveButton tap];
    [collectionViewsQuery.buttons[@"Cancel"] tap];
    
    XCUIElement *clearButton = app.buttons[@"Clear"];
    [clearButton tap];
    
    XCUIElementQuery *collectionViewsQuery2 = app.sheets[@"Clear"].collectionViews;
    [collectionViewsQuery2.buttons[@"Clear"] tap];
    [clearButton tap];
    [collectionViewsQuery2.buttons[@"Cancel"] tap];
    
    [app.buttons[@"red"] tap];
    [app.buttons[@"yellow"] tap];
    [app.buttons[@"green"] tap];
    [app.buttons[@"blue"] tap];
    [app.buttons[@"purple"] tap];
    
}

@end
