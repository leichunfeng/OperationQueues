//
//  OQUseOperationQueueTests.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/2.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OQUseOperationQueue.h"

@interface OQUseOperationQueueTests : XCTestCase

@end

@implementation OQUseOperationQueueTests

- (void)testExecuteOperationUsingOperationQueue {
    OQUseOperationQueue *useOperationQueue = [[OQUseOperationQueue alloc] init];
    [useOperationQueue executeOperationUsingOperationQueue];
}

@end
