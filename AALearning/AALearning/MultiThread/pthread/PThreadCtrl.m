//
//  PThreadCtrl.m
//  AALearning
//
//  Created by LWF on 2017/8/3.
//
//

#import "PThreadCtrl.h"
#import "pthread.h"

@interface PThreadCtrl ()

@end

@implementation PThreadCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"pthread";
    
    /*
     第一个参数&thread是线程对象
     第二个和第四个是线程属性，可赋值NULL
     第三个run表示指向函数的指针(run对应函数里是需要在新线程中执行的任务)
     */
    // 创建线程——定义一个pthread_t类型变量
    pthread_t thread;
    // 开启线程——执行任务
    pthread_create(&thread, NULL, run, NULL);
}

void * run(void *param)    // 新线程调用方法，里边为需要执行的任务
{
    NSLog(@"pthread:%@", [NSThread currentThread]);
    
    return NULL;
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
