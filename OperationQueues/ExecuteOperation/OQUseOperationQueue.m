//
//  OQUseOperationQueue.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/2.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OQUseOperationQueue.h"

@implementation OQUseOperationQueue

- (void)executeOperationUsingOperationQueue {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod) object:nil];
    [operationQueue addOperation:invocationOperation];
    
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Start executing blockOperation1, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing blockOperation1");
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Start executing blockOperation2, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing blockOperation2");
    }];
    
    [operationQueue addOperations:@[ blockOperation1, blockOperation2 ] waitUntilFinished:NO];
    
    [operationQueue addOperationWithBlock:^{
        NSLog(@"Start executing block, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing block");
    }];
    
    [operationQueue waitUntilAllOperationsAreFinished];
}

- (void)taskMethod {
    NSLog(@"Start executing %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
}

@end
