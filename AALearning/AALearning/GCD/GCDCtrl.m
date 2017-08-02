//
//  GCDCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import "GCDCtrl.h"

@interface GCDCtrl ()

@end

@implementation GCDCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 串行队列的创建方法
    dispatch_queue_t serialQueue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    // 并行队列的创建方法
    dispatch_queue_t concurrentQueue1 = dispatch_queue_create("test1.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t concurrentQueue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 同步执行任务创建方法
    dispatch_sync(serialQueue, ^{
        NSLog(@"%@",[NSThread currentThread]);    // 这里放任务代码
    });
    
    // 异步执行任务创建方法
    dispatch_async(concurrentQueue1, ^{
        NSLog(@"%@",[NSThread currentThread]);    // 这里放任务代码
    });
    
    dispatch_async(concurrentQueue2, ^{
        NSLog(@"%@",[NSThread currentThread]);    // 这里放任务代码
    });
    
    [self syncConcurrent];
    [self asyncConcurrent];
    [self syncSerial];
    [self asyncSerial];
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [self syncMain];
    });
    
    [self asyncMain];
    
    //延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
        NSLog(@"run-----");
    });
    
    //GCD的一次性代码(只执行一次)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行1次的代码(这里面默认是线程安全的)
    });
    
    //GCD的快速迭代方法
    /*
     通常我们会用for循环遍历，但是GCD给我们提供了快速迭代的方法dispatch_apply，使我们可以同时遍历。
     比如说遍历0~5这6个数字，for循环的做法是每次取出一个元素，逐个遍历。dispatch_apply可以同时遍历多个数字。
     */
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(50000, queue1, ^(size_t index) {
        NSLog(@"%zd------%@",index, [NSThread currentThread]);
    });
    
    //GCD的队列组
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
    });
}

/*GCD的栅栏方法
 执行完栅栏前面的操作之后，才执行栅栏操作，最后再执行栅栏后边的操作。
 
 我们有时需要异步执行两组操作，而且第一组操作执行完之后，才能开始执行第二组操作。
 这样我们就需要一个相当于栅栏一样的一个方法将两组异步执行的操作组给分割起来，当然这里的操作组里可以包含一个或多个任务。
 这就需要用到dispatch_barrier_async方法在两个操作组间形成栅栏。
 */
- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{ NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{ NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}


/*并行队列 + 同步执行
 所有任务都是在主线程中执行的。由于只有一个线程，所以任务只能一个一个执行。
 任务是添加到队列中马上执行的
 */
- (void) syncConcurrent {
    NSLog(@"syncConcurrent---begin");
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i)
        {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i)
        {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i)
        {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncConcurrent---end");
}


/*并行队列 + 异步执行
 除了主线程，又开启了3个线程，并且任务是交替着同时执行的。
 任务不是马上执行，而是将所有任务添加到队列之后才开始异步执行。
 */
- (void) asyncConcurrent {
    NSLog(@"asyncConcurrent---begin");
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i){
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncConcurrent---end");
}

/*串行队列 + 同步执行
 所有任务都是在主线程中执行的，并没有开启新的线程。而且由于串行队列，所以按顺序一个一个执行。
 任务是添加到队列中马上执行的
 */
- (void) syncSerial {
    NSLog(@"syncSerial---begin");
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncSerial---end");
}

/*串行队列 + 异步执行
 开启了一条新线程，但是任务还是串行，所以任务是一个一个执行。
 任务不是马上执行，而是将所有任务添加到队列之后才开始同步执行。
 */
- (void) asyncSerial {
    NSLog(@"asyncSerial---begin");
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncSerial---end");
}

//主队列 + 同步执行:互等卡住不可行(在主线程中调用)
/*
 在主线程中使用主队列 + 同步执行，任务不再执行了，而且syncMain---end也没有打印
 
 这是因为我们在主线程中执行这段代码。我们把任务放到了主队列中，也就是放到了主线程的队列中。而同步执行有个特点，就是对于任务是立马执行的。
 那么当我们把第一个任务放进主队列中，它就会立马执行。但是主线程现在正在处理syncMain方法，所以任务需要等syncMain执行完才能执行。
 而syncMain执行到第一个任务的时候，又要等第一个任务执行完才能往下执行第二个和第三个任务。
 
 现在的情况就是syncMain方法和第一个任务都在等对方执行完毕。这样大家互相等待，所以就卡住了，所以我们的任务执行不了，而且syncMain---end也没有打印。
 
 要是如果不再主线程中调用，而在其他线程中调用会如何呢？不会开启新线程，执行完一个任务，再执行下一个任务（在其他线程中调用）
 dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
 
 dispatch_async(queue, ^{
 [self syncMain];
 });
 
 在其他线程中使用主队列 + 同步执行可看到：所有任务都是在主线程中执行的，并没有开启新的线程。而且由于主队列是串行队列，所以按顺序一个一个执行。
 同时我们还可以看到，所有任务都在打印的syncConcurrent---begin和syncConcurrent---end之间，这说明任务是添加到队列中马上执行的。
 
 */
- (void)syncMain {
    NSLog(@"syncMain---begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncMain---end");
}

/*主队列 + 异步执行
 所有任务都在主线程中，虽然是异步执行，具备开启线程的能力，但因为是主队列，所以所有任务都在主线程中，并且一个接一个执行。
 任务不是马上执行，而是将所有任务添加到队列之后才开始同步执行。
 */
- (void)asyncMain {
    NSLog(@"asyncMain---begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncMain---end");
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
