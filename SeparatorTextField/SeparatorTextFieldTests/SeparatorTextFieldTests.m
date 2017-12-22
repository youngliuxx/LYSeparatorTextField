//
//  SeparatorTextFieldTests.m
//  SeparatorTextFieldTests
//
//  Created by youngliuxx on 2017/12/15.
//  Copyright © 2017年 youngliuxx. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LYSeparatorTextField+Private.h"

@interface SeparatorTextFieldTests : XCTestCase

@end

@implementation SeparatorTextFieldTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testGetSeparatorLength {
    LYSeparatorTextField *textField = [[LYSeparatorTextField alloc] initWithFrame:CGRectZero format:@"^^^^-^^-^^"];
    textField.text = @"2017-12-17";

    NSInteger result1 = [textField getSeparateLengthWithIndex:8 sequence:LYSeparatorTextFieldSequenceReverse];
    XCTAssertEqual(result1, 1);

    NSInteger result2 = [textField getSeparateLengthWithIndex:9 sequence:LYSeparatorTextFieldSequenceReverse];
    XCTAssertEqual(result2, 0);
    
    NSInteger result3 = [textField getSeparateLengthWithIndex:5 sequence:LYSeparatorTextFieldSequenceReverse];
    XCTAssertEqual(result3, 1);
    
    NSInteger result4 = [textField getSeparateLengthWithIndex:3 sequence:LYSeparatorTextFieldSequenceForward];
    XCTAssertEqual(result4, 1);
    
    NSInteger result5 = [textField getSeparateLengthWithIndex:3 sequence:LYSeparatorTextFieldSequenceReverse];
    XCTAssertEqual(result5, 0);

    NSInteger result6 = [textField getSeparateLengthWithIndex:4 sequence:LYSeparatorTextFieldSequenceReverse];
    XCTAssertEqual(result6, 0);

    LYSeparatorTextField *textField2 = [[LYSeparatorTextField alloc] initWithFrame:CGRectZero format:@"Day:^^ Month:^^ Year:^^"];
    textField2.text = @"Day:12 Month:05 Year:2017";
    
    NSInteger forwardSeparatorLength = [textField2 getSeparateLengthWithIndex:4 sequence:LYSeparatorTextFieldSequenceForward];
    XCTAssertEqual(forwardSeparatorLength, 0);

    NSInteger forwardSeparatorLength2 = [textField2 getSeparateLengthWithIndex:5 sequence:LYSeparatorTextFieldSequenceForward];
    XCTAssertEqual(forwardSeparatorLength2, 7);

    NSInteger forwardSeparatorLength3 = [textField2 getSeparateLengthWithIndex:-1 sequence:LYSeparatorTextFieldSequenceForward];
    XCTAssertEqual(forwardSeparatorLength3, 4);
    
    NSInteger forwardSeparatorLength4 = [textField2 getSeparateLengthWithIndex:4 sequence:LYSeparatorTextFieldSequenceReverse];
    XCTAssertEqual(forwardSeparatorLength4, 4);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
