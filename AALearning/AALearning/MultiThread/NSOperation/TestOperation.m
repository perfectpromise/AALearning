//
//  TestOperation.m
//  AALearning
//
//  Created by LWF on 2017/8/3.
//
//

#import "TestOperation.h"
@interface TestOperation ()

@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) BOOL executing;

@end

@implementation TestOperation

@synthesize finished = _finished;
@synthesize executing = _executing;

- (void)start {
    if ([self isCancelled]) {
        _finished = YES;
        return;
    } else {
        _executing = YES;
        //start your task;
        NSLog(@"------%@", [NSThread currentThread]);
        //end your task
        _executing = NO;
        _finished = YES;
    }
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

@end
