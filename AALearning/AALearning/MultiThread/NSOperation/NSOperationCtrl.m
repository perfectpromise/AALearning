
//
//  NSOperationCtrl.m
//  AALearning
//
//  Created by LWF on 2017/8/3.
//
//

#import "NSOperationCtrl.h"
#import "TestOperation.h"

@interface NSOperationCtrl ()

@end

@implementation NSOperationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"NSOperation（抽象类）";
    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"NSInvocationOperation",@"NSBlockOperation",@"ExecutionBlock",
                            @"继承NSOperation",@"NSOperationQueue主队列",@"NSOperationQueue其他队列",
                            @"最大并发数",@"操作依赖",nil];
    [self addButtonsWithTitle:btnTitleArr];
}

- (void)btnPressed:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
        [op start];
        
    }else if (btn.tag == 1){
        
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            // 在主线程
            NSLog(@"------%@", [NSThread currentThread]);
        }];
        [op start];
        
    }else if (btn.tag == 2){
        
        [self blockOperation];
        
    }else if (btn.tag == 3){
        // 创建TestOperation
        TestOperation *op = [[TestOperation alloc] init];
        [op start];
        
    }else if (btn.tag == 4){//主线程中执行
        [self addOperationWithBlockToQueue];
        
    }else if (btn.tag == 5){//自动放到子线程中执行,同时包含了：串行、并发功能
        [self addOperationToQueue];
        
    }else if (btn.tag == 6){
        [self opetationQueue];
        
    }else if (btn.tag == 7){
        [self addDependency];
    }
}

/*
 开启新线程，进行并发执行
 */
- (void)addOperationToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 2. 创建操作
    // 创建NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 创建NSBlockOperation
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1-----%@", [NSThread currentThread]);
        }
    }];
    // 3. 添加操作到队列中：addOperation:
    [queue addOperation:op1];// [op1 start]
    
    [queue addOperation:op2];// [op2 start]
}

/*
 无需先创建任务，在block中添加任务，直接将任务block加入到队列中
 开启新线程，进行并发执行
 */
- (void)addOperationWithBlockToQueue {
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    // 1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 2. 添加操作到队列中：addOperationWithBlock:
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"-----%@", [NSThread currentThread]);
        }
    }];
}

/*
 控制串行执行和并行执行的关键:maxConcurrentOperationCount
 A:默认情况下为-1，表示不进行限制，默认为并发执行
 B:为1时，进行串行执行(并非只开启一个线程)，开启线程数量由系统决定
 C:大于1时，进行并发执行，当然这个值不应超过系统限制，即使自己设置一个很大的值，系统也会自动调整
*/
- (void)opetationQueue {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 设置最大并发操作数
    queue.maxConcurrentOperationCount = 2;
    // queue.maxConcurrentOperationCount = 1; // 为1就变成了串行队列
    // 添加操作
    [queue addOperationWithBlock:^{
        NSLog(@"1-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"2-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"3-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"4-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"5-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"6-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
}

/*
 操作依赖
 */
- (void)addDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    }];
    [op1 addDependency:op2];
    // 让op1 依赖于 op2，则先执行op2，在执行op1
    [queue addOperation:op1];
    [queue addOperation:op2];
}

- (void)blockOperation {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"1------%@", [NSThread currentThread]);
    }];
    // 添加额外的任务(在子线程执行)
    [op addExecutionBlock:^{
        NSLog(@"2------%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"3------%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"4------%@", [NSThread currentThread]);
    }];
    [op start];
}

- (void)run
{
    for (int i = 0; i < 2; ++i) {
        NSLog(@"2-----%@", [NSThread currentThread]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
