//
//  OQCreateBlockOperationTests.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/1.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OQCreateBlockOperation.h"

@interface OQCreateBlockOperationTests : XCTestCase

@end

@implementation OQCreateBlockOperationTests

- (void)testBlockOperation {
    OQCreateBlockOperation *createBlockOperation = [[OQCreateBlockOperation alloc] init];
    
    NSBlockOperation *blockOperation = [createBlockOperation blockOperation];
    
    [blockOperation start];
}

@end
