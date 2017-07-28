//
//  MethodSwizzlingCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "MethodSwizzlingCtrl.h"
#import <objc/runtime.h>
#import "UIViewController+Swizzle.h"
#import "NSObject+Swizzle.h"

@interface MethodSwizzlingCtrl ()

@end

@implementation MethodSwizzlingCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
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
