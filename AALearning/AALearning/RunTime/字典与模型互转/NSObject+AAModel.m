//
//  NSObject+JsonModel.m
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import "NSObject+AAModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (JsonModel)

/*字典转模型*/
+(id)aa_modelWithDictionary:(NSDictionary *)dic{
    
    if (!dic || dic == (id)kCFNull) return nil;
    if (![dic isKindOfClass:[NSDictionary class]]) return nil;
    
    id objc = [self new];
    //使用CoreFoundation替代Foundation，增加性能
    
    //使用GCD进行快速迭代
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(CFDictionaryGetCount((CFDictionaryRef)dic), queue1, ^(size_t index) {
        
        NSString *key = dic.allKeys[index];
        id value = dic[key];
        
        /*查询属性映射表*/
        if ([objc respondsToSelector:@selector(modelPropertyMapper)]) {
            NSDictionary *propertyMapper = [objc modelPropertyMapper];
            if ([propertyMapper objectForKey:key]) {
                key = [propertyMapper objectForKey:key];
            }
//            [propertyMapper enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSString *mappedToKey, BOOL *stop){
//                
//            }];

        }
        objc_property_t op = class_getProperty(self, [key UTF8String]);
        
        if (op != NULL) { //判断属性是否存在
            if ([value isKindOfClass:[NSString class]] ||
                [value isKindOfClass:[NSNumber class]]) { //常规类型，直接赋值
                [objc setValue:value forKey:key];
                //生成setter方法，并用objc_msgSend调用
                //                NSString *methodName = [NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString,[key substringFromIndex:1]];
                //                SEL setter = sel_registerName(methodName.UTF8String);
                //                if ([objc respondsToSelector:setter]) {
                //                    ((void (*) (id,SEL,id)) objc_msgSend) (objc,setter,value);
                //                }
                
            }else if ([value isKindOfClass:[NSDictionary class]]){//字典中某个value为字典时，进行递归解析
                [objc setValue:[[self classOfPropertyNamed:key] aa_modelWithDictionary:(NSDictionary *)value] forKey:key];
                
            }else if ([value isKindOfClass:[NSArray class]]){//字典中某个value为数组时
                
                SEL sel = NSSelectorFromString(@"typesMap"); //通过该方法找到数组中元素的model
                NSDictionary *types = nil;
                
                if ([objc respondsToSelector:sel]) {
                    
                    types = objc_msgSend(objc,sel);
                    
                    NSString *typeMapStr = [types objectForKey:key];
                    if (typeMapStr) {
                        
                        Class typeMap = NSClassFromString(typeMapStr);
                        NSMutableArray *subObj = [NSMutableArray array];
                        for (id subOP in (NSArray *)value) {
                            
                            if ([subOP isKindOfClass:[NSString class]] ||
                                [subOP isKindOfClass:[NSNumber class]]) {
                                [subObj addObject:subOP];
                            } else if ([subOP isKindOfClass:[NSDictionary class]]) {
                                [subObj addObject:[typeMap aa_modelWithDictionary:(NSDictionary *)subOP]];
                            }
                        }
                        
                        [objc setValue:subObj forKey:key];
                        
                    }else{
                        NSLog(@"%@类不存在", typeMapStr);
                    }
                    
                }else{
                    NSLog(@"找不到映射，无法获知数组元素的model，解析无法继续");
                }
            }
        }else{
            NSLog(@"%@不存在",key);
        }
    });

    return objc;
}

/*模型转字典*/
-(NSDictionary *)dictionaryWithModel{

    __block NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    unsigned int outCount = 0;
    objc_property_t *ops = class_copyPropertyList(object_getClass(self), &outCount);
    
    //使用GCD进行快速迭代
    for (int index = 0; index < outCount; index++) {
        
        objc_property_t op = ops[index];
        NSString *key = [NSString stringWithUTF8String:property_getName(op)];
        id value = [self valueForKey:key];
        Class classObject = object_getClass(value);
        
        if ([value isKindOfClass:[NSString class]] ||
            [value isKindOfClass:[NSNumber class]] ||
            [value isKindOfClass:[NSNull class]]) {
            [dict setObject:value forKey:key];
        }
        else if([value isKindOfClass:[NSArray class]]){
            NSMutableArray *subObj = [NSMutableArray array];
            for (id item in value) {
                [subObj addObject:[item dictionaryWithModel]];
            }
            [dict setObject:subObj forKey:key];
        }
        else if ([value isKindOfClass:[NSDictionary class]] || classObject){
            id subObj = [value dictionaryWithModel];
            [dict setObject:subObj forKey:key];
        }else{
            if (value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    return dict;
}

/*获取属性的类型*/
- (Class)classOfPropertyNamed:(NSString*)propertyName
{
    Class propertyClass = nil;
    objc_property_t property = class_getProperty([self class], [propertyName UTF8String]);
    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
    if (splitPropertyAttributes.count > 0) {
        NSString *encodeType = splitPropertyAttributes[0];
        NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
        NSString *className = splitEncodeType[1];
        propertyClass = NSClassFromString(className);
    }
    return propertyClass;
}

@end

