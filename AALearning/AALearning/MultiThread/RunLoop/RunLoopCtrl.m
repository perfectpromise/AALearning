//
//  RunLoopCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import "RunLoopCtrl.h"

@interface RunLoopCtrl ()
{
    NSTimer *_defaultTimer;
    NSTimer *_trackTimer;
    NSTimer *_commonTimer;
}
@end

@implementation RunLoopCtrl

/*
 CFRunLoopGetCurrent(); // 获得当前线程的RunLoop对象
 CFRunLoopGetMain(); // 获得主线程的RunLoop对象
 
 [NSRunLoop currentRunLoop]; // 获得当前线程的RunLoop对象
 [NSRunLoop mainRunLoop]; // 获得主线程的RunLoop对象
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"运行循环";
    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"DefaultMode",@"TrackingMode",@"CommonModes",
                            @"Observer",@"后台常驻线程",@"取消后台常驻线程",nil];
    [self addButtonsWithTitle:btnTitleArr];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [_defaultTimer invalidate];
    _defaultTimer = nil;
    
    [_trackTimer invalidate];
    _trackTimer = nil;
    
    [_commonTimer invalidate];
    _commonTimer = nil;
}

- (void)btnPressed:(UIButton *)btn{
    
    if (btn.tag == 0) {
        /*
         当我们不做任何操作的时候，RunLoop处于NSDefaultRunLoopMode下
         而当我们拖动Text View的时候，RunLoop就结束NSDefaultRunLoopMode，切换到了UITrackingRunLoopMode模式下，这个模式下没有添加NSTimer，所以我们的NSTimer就不工作了。
         但当我们松开鼠标的时候，RunLoop就结束UITrackingRunLoopMode模式，又切换回NSDefaultRunLoopMode模式，所以NSTimer就又开始正常工作了。
         */
        _defaultTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run:) userInfo:NSDefaultRunLoopMode repeats:YES];
        /*
         scheduledTimerWithTimeInterval：NSTimer会自动被加入到了RunLoop的NSDefaultRunLoopMode模式下
         */

        
    }else if (btn.tag == 1){
        _trackTimer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run:) userInfo:UITrackingRunLoopMode repeats:YES];
        // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
        [[NSRunLoop currentRunLoop] addTimer:_trackTimer forMode:UITrackingRunLoopMode];
        
    }else if (btn.tag == 2){
        _commonTimer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run:) userInfo:NSRunLoopCommonModes repeats:YES];
        // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
        [[NSRunLoop currentRunLoop] addTimer:_commonTimer forMode:NSRunLoopCommonModes];
        
    }else if (btn.tag == 3){
        [self runloopObserver];
        
    }else if (btn.tag == 4){
        // 创建线程，并调用run1方法执行任务
        if (self.thread) {
            self.thread = nil;
        }
        self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run1) object:nil];
        // 开启线程
        [self.thread start];

    }else{
        self.thread = nil;
    }
}

/*
 CFRunLoopObserverRef是观察者，用来监听RunLoop的状态改变 
 kCFRunLoopEntry = (1UL << 0), // 即将进入Loop：1 
 kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理Timer：2    
 kCFRunLoopBeforeSources = (1UL << 2), // 即将处理Source：4 
 kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠：32 
 kCFRunLoopAfterWaiting = (1UL << 6), // 即将从休眠中唤醒：64 
 kCFRunLoopExit = (1UL << 7), // 即将从Loop中退出：128 
 kCFRunLoopAllActivities = 0x0FFFFFFFU // 监听全部状态改变
 */
- (void)runloopObserver{
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd",activity);
    });
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);

}

/*
 CFRunLoopSourceRef按照函数调用栈来分类
 Source0 ：非基于Port
 Source1：基于Port，通过内核和其他线程通信，接收、分发系统事件  (用来接收、分发系统事件，然后再分发到Sources0中处理)
 */
- (void)run:(NSTimer *)time
{
    NSLog(@"%@",[time userInfo]);
}

- (void) run1 {
    // 这里写任务
    NSLog(@"----run1-----");
    // 添加下边两句代码，就可以开启RunLoop，之后self.thread就变成了常驻线程，可随时添加任务，并交于RunLoop处理
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    // 测试是否开启了RunLoop，如果开启RunLoop，则来不了这里，因为RunLoop开启了循环。
    NSLog(@"未开启RunLoop");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 利用performSelector，在self.thread的线程中调用run2方法执行任务
    [self performSelector:@selector(run2) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void) run2 {
    NSLog(@"----run2------");
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
