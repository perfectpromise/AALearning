//
//  NSThreadCtrl.m
//  AALearning
//
//  Created by LWF on 2017/8/3.
//
//

#import "NSThreadCtrl.h"

@interface NSThreadCtrl ()

@end

@implementation NSThreadCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"NSThread";
    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"获取当前线程",@"创建并启动线程",@"创建后自动启动线程",@"隐式创建并启动线程",nil];
    [self addButtonsWithTitle:btnTitleArr];
}

- (void)btnPressed:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        NSLog(@"当前线程:%@",[NSThread currentThread]);
        
    }else if (btn.tag == 1){
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        [thread start]; // 线程一启动，就会在线程thread中执行self的run方法
        
    }else if (btn.tag == 2){
        [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
        
    }else if (btn.tag == 3){
        [self performSelectorInBackground:@selector(run) withObject:nil];
        
    }
}

/*
 // 获得主线程 
 + (NSThread *)mainThread; 
 
 // 判断是否为主线程(对象方法) 
 - (BOOL)isMainThread; 
 
 // 判断是否为主线程(类方法) 
 + (BOOL)isMainThread; 
 
 // 获得当前线程 
 NSThread *current = [NSThread currentThread]; 
 
 // 线程的名字——setter方法 
 - (void)setName:(NSString *)n; 
 
 // 线程的名字——getter方法 
 - (NSString *)name;

 // 线程进入就绪状态 -> 运行状态。当线程任务执行完毕，自动进入死亡状态
 - (void)start;
 
 // 线程进入阻塞状态
 + (void)sleepUntilDate:(NSDate *)date;
 + (void)sleepForTimeInterval:(NSTimeInterval)ti;

 // 线程进入死亡状态
 + (void)exit;
 
 
 
 */
- (void)run{
    NSLog(@"NSThread is Running");
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
