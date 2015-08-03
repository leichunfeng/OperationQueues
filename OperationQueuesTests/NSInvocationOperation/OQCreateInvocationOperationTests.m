//
//  OQCreateInvocationOperationTests.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/1.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OQCreateInvocationOperation.h"

@interface OQCreateInvocationOperationTests : XCTestCase

@end

@implementation OQCreateInvocationOperationTests

- (void)testInvocationOperationWithData {
    OQCreateInvocationOperation *createInvocationOperation = [[OQCreateInvocationOperation alloc] init];
    
    NSInvocationOperation *invocationOperation = [createInvocationOperation invocationOperationWithData:@"leichunfeng"];
    
    [invocationOperation start];
}

- (void)testInvocationOperationWithData_userInput_1 {
    OQCreateInvocationOperation *createInvocationOperation = [[OQCreateInvocationOperation alloc] init];
    
    NSInvocationOperation *invocationOperation = [createInvocationOperation invocationOperationWithData:@"leichunfeng" userInput:@"Hello NSInvocationOperation!"];
    
    [invocationOperation start];
}

- (void)testInvocationOperationWithData_userInput_2 {
    OQCreateInvocationOperation *createInvocationOperation = [[OQCreateInvocationOperation alloc] init];
    
    NSInvocationOperation *invocationOperation = [createInvocationOperation invocationOperationWithData:@"leichunfeng" userInput:nil];
    
    [invocationOperation start];
}

@end
