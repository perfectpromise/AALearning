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

    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"GCD",@"pthread",@"NSThread",@"NSOperation",@"Block",@"RunLoop", nil];
    for (int i = 0;i < btnTitleArr.count;i++) {
        NSString *title = btnTitleArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(60.0,50+70*i , ScreenWidth-120, 50.0);
        [btn setBackgroundImage:[UIImage imageNamed:@"base_btn"] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.view addSubview:btn];
    }

}

- (void)btnPressed:(UIButton *)btn{
    
    NSArray *controllerArr = [NSArray arrayWithObjects:@"GCDCtrl",
                              @"PThreadCtrl",
                              @"NSThreadCtrl",
                              @"NSOperationCtrl",
                              @"BlockCtrl",
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
