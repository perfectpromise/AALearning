//
//  Monkey.m
//  RuntimeLearn
//
//  Created by 戴尼玛 on 16/4/26.
//  Copyright © 2016年 MIMO. All rights reserved.
//

#import "Monkey.h"
#import "Bird.h"
#import <objc/runtime.h>

@implementation Monkey

/*
 1.进入 resolveInstanceMethod: 方法，指定是否动态添加方法。若返回NO，则进入下一步，若返回YES，则通过 class_addMethod 函数动态地添加方法，消息得到处理，此流程完毕。
 2.resolveInstanceMethod: 方法返回 NO 时，就会进入 forwardingTargetForSelector: 方法，这是 Runtime 给我们的第二次机会，用于指定哪个对象响应这个 selector。返回nil，进入下一步，返回某个对象，则会调用该对象的方法。
 3.若 forwardingTargetForSelector: 返回的是nil，则我们首先要通过 methodSignatureForSelector: 来指定方法签名，返回nil，表示不处理，若返回方法签名，则会进入下一步。
 4.当第 methodSignatureForSelector: 方法返回方法签名后，就会调用 forwardInvocation: 方法，我们可以通过 anInvocation 对象做很多处理，比如修改实现方法，修改响应对象等。
 如果到最后，消息还是没有得到响应，程序就会crash
 */
-(void)jump{
    NSLog(@"monkey can not fly, but! monkey can jump");
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    /*
     如果当前对象调用了一个不存在的方法
     Runtime会调用resolveInstanceMethod:来进行动态方法解析
     我们需要用class_addMethod函数完成向特定类添加特定方法实现的操作
     返回NO，则进入下一步forwardingTargetForSelector:
     */
    NSLog(@"resolveInstanceMethod");
#if 1
    return NO;
#else
    class_addMethod(self, sel, class_getMethodImplementation(self, sel_registerName("jump")), "v@:");
    return [super resolveInstanceMethod:sel];
#endif
}

-(id)forwardingTargetForSelector:(SEL)aSelector{
    
    /*
     在消息转发机制执行前，Runtime 系统会再给我们一次重定向的机会
     通过重载forwardingTargetForSelector:方法来替换消息的接受者为其他对象
     返回nil则进步下一步forwardInvocation:
     */
    NSLog(@"forwardingTargetForSelector");
#if 1
    return nil;
#else
    return [[Bird alloc] init];
#endif
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    /*
     获取方法签名进入下一步，进行消息转发
     */
    
    NSLog(@"methodSignatureForSelector");

    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel rangeOfString:@"set"].location == 0) {
        //动态造一个 setter函数
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        //动态造一个 getter函数
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
    /*
     消息转发
     */
    NSLog(@"forwardInvocation");
    return [anInvocation invokeWithTarget:[[Bird alloc] init]];
}

@end
