//
//  NSObject+JsonModel.h
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+JsonModel.h"

@interface NSObject (JsonModel)

/*字典转模型*/
+(id)objectWithDictionary:(NSDictionary *)dic;

/*模型转字典*/
+(NSDictionary *)dictionaryWithObject:(id)obj;

- (Class)classOfPropertyNamed:(NSString*)propertyName;

@end
