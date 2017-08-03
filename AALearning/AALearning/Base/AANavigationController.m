//
//  AANavigationController.m
//  WaterWallet
//
//  Created by LWF on 17/7/18.
//  Copyright © 2017年 贾富珍. All rights reserved.
//

#import "AANavigationController.h"

#define BACK_BTN_FRAME CGRectMake(0.0f, 18.0f, 45.0f, 25.0f)        //导航栏返回按钮尺寸

@interface AANavigationController ()
@end

@implementation AANavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        UINavigationBar *navBar = [UINavigationBar appearance];
        navBar.barTintColor = [UIColor blackColor];
        
        UIColor * color = [UIColor whiteColor];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
        self.navigationBar.titleTextAttributes = dict;
        self.navigationBar.translucent = NO;
        self.interactivePopGestureRecognizer.enabled = NO;//根视图禁止滑动，否则容易造成卡死
        /*POP到根视图，仍然需要禁止，在delegate中实现*/
    }
    
    return self;
}

//返回上层界面
-(void)popself
{
    [self popViewControllerAnimated:YES];
}

//自定义返回按钮
-(UIBarButtonItem*) createBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:BACK_BTN_FRAME];
    [button addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return leftitem;
}

//push进入下一层界面
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }else{
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -20;
                
        viewController.navigationItem.leftBarButtonItems =[NSArray arrayWithObjects:negativeSeperator,[self createBackButton], nil];
    }
    
    if (![viewController isKindOfClass:[UITabBarController class]]) {
        //开启iOS7的滑动返回效果
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = nil;
        }
    }
}

@end

@implementation UINavigationController (Rotation)


- (BOOL)shouldAutorotate
{
    UIViewController *vCtrl = [self.viewControllers lastObject];
    if ([vCtrl isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabbarCtrl = (UITabBarController *)vCtrl;
        
        return [[tabbarCtrl.viewControllers lastObject] shouldAutorotate];
    }
    
    return [[self.viewControllers lastObject] shouldAutorotate];
}


- (NSUInteger)supportedInterfaceOrientations
{
    UIViewController *vCtrl = [self.viewControllers lastObject];
    if ([vCtrl isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabbarCtrl = (UITabBarController *)vCtrl;
        
        return [[tabbarCtrl.viewControllers lastObject] shouldAutorotate];
    }
    
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIViewController *vCtrl = [self.viewControllers lastObject];
    if ([vCtrl isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabbarCtrl = (UITabBarController *)vCtrl;
        
        return [[tabbarCtrl.viewControllers lastObject] shouldAutorotate];
    }
    
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}
@end
