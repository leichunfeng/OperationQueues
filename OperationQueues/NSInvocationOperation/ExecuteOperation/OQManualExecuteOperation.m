//
//  OQManualExecuteOperation.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/2.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OQManualExecuteOperation.h"

@implementation OQManualExecuteOperation

- (BOOL)manualPerformOperation:(NSOperation *)operation {
    BOOL ranIt = NO;
    
    if (operation.isCancelled) {
        ranIt = YES;
    } else if (operation.isReady) {
        if (![operation isConcurrent]) {
            [operation start];
        } else {
            [NSThread detachNewThreadSelector:@selector(start) toTarget:operation withObject:nil];
        }
        ranIt = YES;
    }
    
    return ranIt;
}

@end
