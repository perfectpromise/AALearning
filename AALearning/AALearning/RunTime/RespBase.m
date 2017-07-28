//
//  RespBase.m
//  BeadWallet
//
//  Created by LWF on 17/7/20.
//  Copyright © 2017年 贾富珍. All rights reserved.
//

#import "RespBase.h"
#import <objc/runtime.h>

@implementation RespBase

/*
 class_copyPropertyList：仅返回@property属性变量
 class_copyIvarList：返回@property和@interface大括号中声明的变量
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int outCount = 0;
        objc_property_t *propertys = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = propertys[i];
            const char *name = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &outCount);
    for (int i = 0;i < outCount; i++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

@end
