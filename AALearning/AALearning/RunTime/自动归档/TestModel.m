

#import "TestModel.h"
#import <objc/runtime.h>

@implementation Library
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
        
        // 注意kvc的特性是，如果能找到key这个属性的setter方法，则调用setter方法
        // 如果找不到setter方法，则查找成员变量key或者成员变量_key，并且为其赋值
        // 所以这里不需要再另外处理成员变量名称的“_”前缀
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}
@end

@implementation DiningRoom
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
        
        // 注意kvc的特性是，如果能找到key这个属性的setter方法，则调用setter方法
        // 如果找不到setter方法，则查找成员变量key或者成员变量_key，并且为其赋值
        // 所以这里不需要再另外处理成员变量名称的“_”前缀
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}
@end

@implementation TestModel

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
        
        // 注意kvc的特性是，如果能找到key这个属性的setter方法，则调用setter方法
        // 如果找不到setter方法，则查找成员变量key或者成员变量_key，并且为其赋值
        // 所以这里不需要再另外处理成员变量名称的“_”前缀
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

/*字典转模型时使用：
 字典中某个value为数组时，用来指出该数组中的数据的model
 */
-(NSDictionary*)typesMap
{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"DiningRoom",@"diningRoom", nil];
}

@end
