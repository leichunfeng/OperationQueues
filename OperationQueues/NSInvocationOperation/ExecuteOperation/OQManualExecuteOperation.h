//
//  OQManualExecuteOperation.h
//  OperationQueues
//
//  Created by leichunfeng on 15/8/2.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OQManualExecuteOperation : NSObject

- (BOOL)manualPerformOperation:(NSOperation *)operation;

@end
