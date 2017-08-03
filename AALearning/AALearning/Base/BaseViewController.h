//
//  BaseViewController.h
//  WaterWallet
//
//  Created by LWF on 17/7/18.
//  Copyright © 2017年 贾富珍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width       //屏幕宽度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height     //屏幕高度
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]  //颜色设置

@interface BaseViewController : UIViewController

- (void)addButtonsWithTitle:(NSArray *)titleArr;

@end
