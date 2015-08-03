//
//  OQCreateInvocationOperation.h
//  OperationQueues
//
//  Created by leichunfeng on 15/8/1.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OQCreateInvocationOperation : NSObject

- (NSInvocationOperation *)invocationOperationWithData:(id)data;
- (NSInvocationOperation *)invocationOperationWithData:(id)data userInput:(NSString *)userInput;

@end
