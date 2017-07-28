/*
 假设一个场景：
 1、TestModel是学校类，包含以下属性：学校名称、师生数量、一个图书馆、两个食堂
 2、Library是图书馆类，包含以下属性：名称、剩余书本数量
 3、DiningRoom是食堂类，包含以下属性：名称
 */

#import <Foundation/Foundation.h>

@interface Library : NSObject<NSCoding>

@property (strong,nonatomic) NSString *name;    //名称
@property (assign,nonatomic) NSInteger borrowerCount;   //剩余书本数量

@end

@interface DiningRoom : NSObject<NSCoding>

@property (strong,nonatomic) NSString *name;    //名称

@end

@interface TestModel : NSObject<NSCoding>

@property (strong,nonatomic) NSString *name;    //学校名称
@property (assign,nonatomic) NSInteger count;   //师生数量
@property (strong,nonatomic) Library *library;
@property (strong,nonatomic) NSArray<DiningRoom*> *diningRoom;

@end

