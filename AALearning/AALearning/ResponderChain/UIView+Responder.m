//
//  UIView+Responder.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "UIView+Responder.h"
#import "NSObject+Swizzle.h"

@implementation UIView (Responder)

+ (void)load{ //父类->子类->类别
    
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [self swizzleInstanceMethod:@selector(touchesBegan:withEvent:) withMethod:@selector(ds_touchesBegan:withEvent:)];
//        [self swizzleInstanceMethod:@selector(touchesMoved:withEvent:) withMethod:@selector(ds_touchesMoved:withEvent:)];
//        [self swizzleInstanceMethod:@selector(touchesEnded:withEvent:) withMethod:@selector(ds_touchesEnded:withEvent:)];
//        [self swizzleInstanceMethod:@selector(hitTest:withEvent:) withMethod:@selector(ds_hitTest:withEvent:)];
//        [self swizzleInstanceMethod:@selector(pointInside:withEvent:) withMethod:@selector(ds_pointInside:withEvent:)];

    });
    
}

#pragma mark -
- (void)ds_touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ touch begin", self.class);
    UIResponder *next = [self nextResponder];
    while (next) {
        NSLog(@"%@",next.class);
        next = [next nextResponder];
    }
}

- (void)ds_touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ touch move", self.class);
}

- (void)ds_touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ touch end", self.class);
}

//模拟一下，系统真正的实现肯定不是这样的，毕竟事件我都没用上。。
- (UIView *)ds_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) return nil;
    //判断点在不在这个视图里
    if ([self pointInside:point withEvent:event]) {
        //在这个视图 遍历该视图的子视图
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            //转换坐标到子视图
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            //递归调用hitTest:withEvent继续判断
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                //在这里打印self.class可以看到递归返回的顺序。
                return hitTestView;
            }
        }
        //这里就是该视图没有子视图了 点在该视图中，所以直接返回本身，上面的hitTestView就是这个。
        NSLog(@"命中的view:%@",self.class);
        return self;
    }
    //不在这个视图直接返回nil
    return nil;
}

- (BOOL)ds_pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    BOOL success = CGRectContainsPoint(self.bounds, point);
    if (success) {
        NSLog(@"点在%@里",self.class);
    }else {
        NSLog(@"点不在%@里",self.class);
    }
    return success;
}
@end
