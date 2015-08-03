//
//  OQNonConcurrentOperation.m
//  OperationQueues
//
//  Created by leichunfeng on 15/8/1.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OQNonConcurrentOperation.h"

@interface OQNonConcurrentOperation ()

@property (strong, nonatomic) id data;

@end

@implementation OQNonConcurrentOperation

- (id)initWithData:(id)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

/*
///  不支持取消操作
- (void)main {
    @try {
        NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), self.data, [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    }
    @catch(NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}
*/

///  支持取消操作
- (void)main {
    @try {
        if (self.isCancelled) return;
        
        NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), self.data, [NSThread mainThread], [NSThread currentThread]);
        
        for (NSUInteger i = 0; i < 3; i++) {
            if (self.isCancelled) return;
            
            sleep(1);
            
            NSLog(@"Loop %@", @(i + 1));
        }

        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    }
    @catch(NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

@end
