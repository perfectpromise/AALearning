//
//  BaseViewController.m
//  WaterWallet
//
//  Created by LWF on 17/7/18.
//  Copyright © 2017年 贾富珍. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    //[SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBACOLOR(245, 245, 245, 1.0);
    self.view.userInteractionEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.view endEditing:YES];
}

- (void)setupRightMenuButton:(NSString *)imgName
                       title:(NSString *)titleStr{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setTitle:titleStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setFrame:CGRectMake(5.0f, 5.0f, 46.0f, 46.0f)];
    [button addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *barSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    barSpace.width = -10;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barSpace, barBtn, nil];
}

- (void)rightBtnPressed{
    //子类重写该方法
}

- (void)addButtonsWithTitle:(NSArray *)titleArr{
    for (int i = 0;i < titleArr.count;i++) {
        NSString *title = titleArr[i];
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
    //子类重写该方法
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

#pragma mark -触摸关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view resignFirstResponder];
    [self.view endEditing:YES];
}
@end
