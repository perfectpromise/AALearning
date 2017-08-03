//
//  NSObject+Swizzle.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+(void)swizzleInstanceMethod:(SEL)origSel withMethod:(SEL)mySel{
    
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method myMethod = class_getInstanceMethod(self, mySel);
    
    BOOL success = class_addMethod(self, origSel,
                                   method_getImplementation(myMethod),
                                   method_getTypeEncoding(myMethod));
    if (!success) {
        
        method_exchangeImplementations(origMethod, myMethod);
    }else{
        class_replaceMethod(self, mySel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
}

+(void)swizzleClassMethod:(SEL)origSel withMethod:(SEL)mySel{
    
    Method origMethod = class_getClassMethod(self, origSel);
    Method myMethod = class_getClassMethod(self, mySel);
    
    BOOL success = class_addMethod(self, origSel,
                                   method_getImplementation(origMethod),
                                   method_getTypeEncoding(origMethod));
    if (!success) {
        
        method_exchangeImplementations(origMethod, myMethod);
    }else{
        class_replaceMethod(self, mySel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
}

@end
