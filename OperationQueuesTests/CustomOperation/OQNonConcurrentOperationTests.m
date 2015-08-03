//
//  OQNonConcurrentOperationTests.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/1.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OQNonConcurrentOperation.h"

@interface OQNonConcurrentOperationTests : XCTestCase

@end

@implementation OQNonConcurrentOperationTests

- (void)testInitWithData_1 {
    OQNonConcurrentOperation *nonConcurrentOperation = [[OQNonConcurrentOperation alloc] initWithData:@"leichunfeng"];
    [nonConcurrentOperation start];
}

- (void)testInitWithData_2 {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    OQNonConcurrentOperation *nonConcurrentOperation = [[OQNonConcurrentOperation alloc] initWithData:@"leichunfeng"];
    
    [operationQueue addOperation:nonConcurrentOperation];
    
//    /*
    sleep(1);

    [nonConcurrentOperation cancel];
//    */
    
    [operationQueue waitUntilAllOperationsAreFinished];
}

@end
