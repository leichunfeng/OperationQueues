//
//  OQManualExecuteOperationTests.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/2.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OQManualExecuteOperation.h"

@interface OQManualExecuteOperationTests : XCTestCase

@end

@implementation OQManualExecuteOperationTests

- (void)testManualPerformOperation {
    OQManualExecuteOperation *manualExecuteOperation = [[OQManualExecuteOperation alloc] init];

    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Start executing blockOperation, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing blockOperation");
    }];
    
    [manualExecuteOperation manualPerformOperation:blockOperation];
}

@end
