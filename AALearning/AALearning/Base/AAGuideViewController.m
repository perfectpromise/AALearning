//
//  AAGuideViewController.m
//  BeadWallet
//
//  Created by LWF on 2017/8/2.
//  Copyright © 2017年 贾富珍. All rights reserved.
//

#import "AAGuideViewController.h"
#import "AATabBarController.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width       //屏幕宽度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height     //屏幕高度

@interface AAGuideViewController ()<UIScrollViewDelegate>
{
    // 创建页码控制器
    UIPageControl *pageControl;
}


@end

@implementation AAGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    for (int i=0; i<4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%d_1.2",i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight)];
        // 在最后一页创建按钮
        if (i == 3) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((ScreenWidth - 240) /2, ScreenHeight*0.84, 240, 40 );
            [button setImage:[UIImage imageNamed:@"intoAPP"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(ScreenWidth * 4, ScreenHeight);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(ScreenWidth / 3, ScreenHeight * 15 / 16, ScreenWidth / 3, ScreenHeight / 16)];
    // 设置页数
    pageControl.numberOfPages = 3;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}
// 点击按钮保存数据并切换根视图控制器
- (void) go:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaungh"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 切换根视图控制器
    self.view.window.rootViewController = [AATabBarController new];
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
