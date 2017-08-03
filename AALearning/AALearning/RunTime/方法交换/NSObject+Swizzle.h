//
//  NSObject+Swizzle.h
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+(void)swizzleInstanceMethod:(SEL)origSel withMethod:(SEL)mySel;
+(void)swizzleClassMethod:(SEL)origSel withMethod:(SEL)mySel;

@end
