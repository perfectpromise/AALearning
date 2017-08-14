//
//  NSObject+JsonModel.h
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+AAModel.h"

@interface NSObject (AAModel)

/*字典转模型*/
+(id)aa_modelWithDictionary:(NSDictionary *)dic;

/*模型转字典*/
-(NSDictionary *)dictionaryWithModel;

/*json中key与model中属性的映射*/
+ (NSDictionary*)modelPropertyMapper;

/*json中key与model映射，即Json中的value还是json*/
+ (NSDictionary *)modelContainerPropertyGenericClass;

- (Class)classOfPropertyNamed:(NSString*)propertyName;

@end
