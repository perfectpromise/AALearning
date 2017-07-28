//
//  RuntimeCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "RuntimeCtrl.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface RuntimeCtrl ()

@end

@implementation RuntimeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    /*消息发送：[self sendMsg:@"test"]*/
    objc_msgSend(self, @selector(sendMsg:),@"test");
}

- (void)sendMsg:(NSString *)test{
    
    NSLog(@"Runtime函数调用:%@",test);
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
