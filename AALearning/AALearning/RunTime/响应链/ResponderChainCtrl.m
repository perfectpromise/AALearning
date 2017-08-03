//
//  ResponderChainCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "ResponderChainCtrl.h"
#import "UIView+Responder.h"
#import "NSObject+Swizzle.h"

@interface ResponderChainCtrl ()

@end

@implementation ResponderChainCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建4个UIView
    self.view.backgroundColor = [UIColor redColor];
    
    [[UIView class] swizzleInstanceMethod:@selector(touchesBegan:withEvent:) withMethod:@selector(ds_touchesBegan:withEvent:)];
    [[UIView class] swizzleInstanceMethod:@selector(touchesMoved:withEvent:) withMethod:@selector(ds_touchesMoved:withEvent:)];
    [[UIView class] swizzleInstanceMethod:@selector(touchesEnded:withEvent:) withMethod:@selector(ds_touchesEnded:withEvent:)];
    
    //B和D：加在A之上，相互无重叠
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(50.0, 150.0, 100.0, 100.0)];
    bView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bView];
    
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(50.0, 280.0, 100.0, 100.0)];
    dView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:dView];
    
    //C：加在B上
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 25.0, 50.0, 50.0)];
    cView.backgroundColor = [UIColor greenColor];
    [bView addSubview:cView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aviewAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)aviewAction {
    NSLog(@"单击");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[UIView class] swizzleInstanceMethod:@selector(ds_touchesBegan:withEvent:) withMethod:@selector(touchesBegan:withEvent:)];
    [[UIView class] swizzleInstanceMethod:@selector(ds_touchesMoved:withEvent:) withMethod:@selector(touchesMoved:withEvent:)];
    [[UIView class] swizzleInstanceMethod:@selector(ds_touchesEnded:withEvent:) withMethod:@selector(touchesEnded:withEvent:)];
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

@end
