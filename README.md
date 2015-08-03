# OperationQueues

我的博文[《iOS 并发编程之 Operation Queues》](http://blog.leichunfeng.com/blog/2015/07/29/ios-concurrency-programming-operation-queues/)的完整配套代码。

创建 NSInvocationOperation 对象：

``` objc
@interface OQCreateInvocationOperation : NSObject

- (NSInvocationOperation *)invocationOperationWithData:(id)data;
- (NSInvocationOperation *)invocationOperationWithData:(id)data userInput:(NSString *)userInput;

@end

@implementation OQCreateInvocationOperation

- (NSInvocationOperation *)invocationOperationWithData:(id)data {
    return [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(myTaskMethod1:) object:data];
}

- (NSInvocationOperation *)invocationOperationWithData:(id)data userInput:(NSString *)userInput {
    NSInvocationOperation *invocationOperation = [self invocationOperationWithData:data];
    
    if (userInput.length == 0) {
        invocationOperation.invocation.selector = @selector(myTaskMethod2:);
    }
    
    return invocationOperation;
}

- (void)myTaskMethod1:(id)data {
    NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), data, [NSThread mainThread], [NSThread currentThread]);
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
}

- (void)myTaskMethod2:(id)data {
    NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), data, [NSThread mainThread], [NSThread currentThread]);
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
}

@end
```

创建 NSBlockOperation 对象：

``` objc
@interface OQCreateBlockOperation : NSObject

- (NSBlockOperation *)blockOperation;

@end

@implementation OQCreateBlockOperation

- (NSBlockOperation *)blockOperation {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Start executing block1, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing block1");
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"Start executing block2, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing block2");
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"Start executing block3, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing block3");
    }];
    
    return blockOperation;
}

@end
```

自定义非并发的 Operation 对象：

``` objc
@interface OQNonConcurrentOperation : NSOperation

- (instancetype)initWithData:(id)data;

@end

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
```

自定义并发的 Operation 对象：

``` objc
@interface OQConcurrentOperation : NSOperation

@end

@implementation OQConcurrentOperation

@synthesize executing = _executing;
@synthesize finished  = _finished;

- (id)init {
    self = [super init];
    if (self) {
        _executing = NO;
        _finished  = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (void)start {
    if (self.isCancelled) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _executing = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        NSLog(@"Start executing %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);

        sleep(3);
        
        [self willChangeValueForKey:@"isExecuting"];
        _executing = NO;
        [self didChangeValueForKey:@"isExecuting"];

        [self willChangeValueForKey:@"isFinished"];
        _finished  = YES;
        [self didChangeValueForKey:@"isFinished"];

        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

@end
```

使用 Operation Queue 执行 Operation 对象：

``` objc
@interface OQUseOperationQueue : NSObject

- (void)executeOperationUsingOperationQueue;

@end

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
```

手动执行 Operation 对象：

``` objc
@interface OQManualExecuteOperation : NSObject

- (BOOL)manualPerformOperation:(NSOperation *)operation;

@end

@implementation OQManualExecuteOperation

- (BOOL)manualPerformOperation:(NSOperation *)operation {
    BOOL ranIt = NO;
    
    if (operation.isCancelled) {
        ranIt = YES;
    } else if (operation.isReady) {
        if (!operation.isConcurrent) {
            [operation start];
        } else {
            [NSThread detachNewThreadSelector:@selector(start) toTarget:operation withObject:nil];
        }
        ranIt = YES;
    }
    
    return ranIt;
}

@end
```
