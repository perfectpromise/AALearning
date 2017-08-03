//
//  MultiThreadCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import "MultiThreadCtrl.h"

@interface MultiThreadCtrl ()

@end

@implementation MultiThreadCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"多线程";

    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"GCD",@"pthread",@"NSThread",@"NSOperation",@"RunLoop", nil];
    [self addButtonsWithTitle:btnTitleArr];
}

- (void)btnPressed:(UIButton *)btn{
    
    NSArray *controllerArr = [NSArray arrayWithObjects:@"GCDCtrl",
                              @"PThreadCtrl",
                              @"NSThreadCtrl",
                              @"NSOperationCtrl",
                              @"RunLoopCtrl",nil];
    
    BaseViewController *viewCtrl = [NSClassFromString(controllerArr[btn.tag]) new];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
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
