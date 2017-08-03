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
                            @"",@"",@"",
                            @"",@"",nil];
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

        
    }else if (btn.tag == 4){
        
    }else if (btn.tag == 5){
        
    }else if (btn.tag == 6){
        
    }else if (btn.tag == 7){
    }
}

- (void)run:(NSTimer *)time
{
    NSLog(@"%@",[time userInfo]);
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
