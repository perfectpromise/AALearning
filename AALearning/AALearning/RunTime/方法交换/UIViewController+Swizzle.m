//
//  UIViewController+Swizzle.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "UIViewController+Swizzle.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzle)

/*最好不要去做这种事，测试中发现，滑动返回页面出现白屏，点击事件还能正常响应，所有视图看不到了*/
+ (void)load{ //父类->子类->类别
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [self swizzleInstanceMethod:@selector(viewDidLoad) withMethod:@selector(bw_viewDidLoad)];
    });

}

- (void)bw_viewDidLoad{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![str containsString:@"UI"]){
        NSLog(@"viewDidLoad方法交换 : %@", self.class);
    }
    [self bw_viewDidLoad];
}
@end
