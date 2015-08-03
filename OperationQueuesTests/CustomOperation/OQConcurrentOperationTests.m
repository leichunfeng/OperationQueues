//
//  OQConcurrentOperationTests.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/2.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OQConcurrentOperation.h"

@interface OQConcurrentOperationTests : XCTestCase

@end

@implementation OQConcurrentOperationTests

- (void)testConcurrentOperation {
    OQConcurrentOperation *concurrentOperation = [[OQConcurrentOperation alloc] init];
    [concurrentOperation start];
    [concurrentOperation waitUntilFinished];
}

@end
