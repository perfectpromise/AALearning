//
//  TestMsgSend.m
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import "TestMsgSend.h"

@implementation TestMsgSend

-(void)showAge{
    NSLog(@"1");
}

-(void)showName:(NSString *)aName{
    NSLog(@"姓名：%@",aName);
}

-(void)showWeight:(float)aWeight andHeight:(float)aHeight{
    NSLog(@"体重：%fKG 高：%fCM",aWeight, aHeight);
}

-(float)getHeight{
    return 187.5f;
}

-(NSString *)getInfo{
    return @"大家好，我叫安安，今年1岁，身高80CM，体重10KG。";
}

@end
