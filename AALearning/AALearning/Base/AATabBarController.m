//
//  AATabBarController.m
//  WaterWallet
//
//  Created by LWF on 17/7/18.
//  Copyright © 2017年 贾富珍. All rights reserved.
//

#import "AATabBarController.h"
#import "BaseViewController.h"
#import "AANavigationController.h"

@interface AATabBarController ()<UIGestureRecognizerDelegate>

@end

@implementation AATabBarController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    [self.selectedViewController viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self.selectedViewController viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TarBar初始化,数据初始化
    NSArray *titleArr = [NSArray arrayWithObjects:@"Runtime",@"多线程",@"我的", nil];
    NSArray *controllerArr = [NSArray arrayWithObjects:@"RuntimeCtrl",
                              @"RuntimeCtrl",
                              @"RuntimeCtrl", nil];
    NSArray *imgNormalArr = [NSArray arrayWithObjects:@"tabbar_home",@"tabbar_recommend",@"tabbar_mine", nil];
    NSArray *imgSelectedArr = [NSArray arrayWithObjects:@"tabbar_home_s",@"tabbar_recommend_s",@"tabbar_mine_s", nil];

    //控制器初始化
    NSMutableArray *tabbarArr = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++) {
        
        BaseViewController *viewCtrl = [NSClassFromString(controllerArr[i]) new];
        
        AANavigationController *navCtrl = [[AANavigationController alloc] initWithRootViewController:viewCtrl];
        navCtrl.tabBarItem.title = titleArr[i];
        navCtrl.tabBarItem.image = [UIImage imageNamed:imgNormalArr[i]];
        navCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:imgSelectedArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
        [tabbarArr addObject:navCtrl];
    }
    
    // 分栏条的背景颜色
    [self.tabBar setValue:[UIColor whiteColor] forKey:@"barTintColor"];
    self.tabBar.tintColor = RGBACOLOR(85, 209, 218, 1.0);
    self.viewControllers = tabbarArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIDeviceOrientationPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return UIInterfaceOrientationPortrait;
}

@end
