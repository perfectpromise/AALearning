//
//  NSObject+Extention.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

static char *NSObjectNameKey = "NSObjectNameKey";

-(void)setName:(NSString *)name{ /*
                                  OBJC_ASSOCIATION_ASSIGN;            //assign策略
                                  OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
                                  OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
                                  
                                  OBJC_ASSOCIATION_RETAIN;
                                  OBJC_ASSOCIATION_COPY;
                                  */ /*
                                      * id object 给哪个对象的属性赋值
                                      const void *key 属性对应的key
                                      id value  设置属性值为value
                                      objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
                                      objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
                                      */
    objc_setAssociatedObject(self, &NSObjectNameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)name{
    return objc_getAssociatedObject(self, &NSObjectNameKey);
}


@end
