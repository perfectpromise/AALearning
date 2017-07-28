//
//  RuntimeCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//  
//

#import "RuntimeCtrl.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+JsonModel.h"
#import "TestModel.h"
#import "TestMsgSend.h"
#import "Monkey.h"

@interface RuntimeCtrl ()

@end

@implementation RuntimeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    /*消息发送：[self sendMsg:@"test"]*/
    TestMsgSend *msgSend = [TestMsgSend new];
    ((void (*) (id, SEL))objc_msgSend)(msgSend, sel_registerName("showAge"));
    ((void (*) (id, SEL, NSString *))objc_msgSend)(msgSend, sel_registerName("showName:"),@"安安");
    ((void (*) (id, SEL, float, float)) objc_msgSend)(msgSend, sel_registerName("showWeight:andHeight:"),10.0f,80.0f);
    float height = ((float (*) (id, SEL)) objc_msgSend_fpret)(msgSend, sel_registerName("getHeight"));
    NSString *info = ((NSString* (*) (id, SEL)) objc_msgSend)(msgSend, sel_registerName("getInfo"));
    
    NSLog(@"身高：%f CM，基本信息：%@",height,info);
    
    /*字典转模型*/
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"武汉大学",@"name",
                         @"10859",@"count",
                         [NSDictionary dictionaryWithObjectsAndKeys:@"国立图书馆",@"name",
                                     @"88888",@"borrowerCount",
                                     nil],@"library",
                         [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"东食堂",@"name",nil],
                                                                   [NSDictionary dictionaryWithObjectsAndKeys:@"西食堂",@"name",nil], nil],@"diningRoom",nil];

    TestModel *model =  [TestModel objectWithDictionary:dic];
    NSLog(@"%@",model.name);
    
    /*模型转字典*/
    NSDictionary *modelDic = [TestModel dictionaryWithObject:model];
    NSLog(@"%@",modelDic);
    
    /*动态方法解析*/
    Monkey *monkey = [Monkey new];
    objc_msgSend(monkey, sel_registerName("fly"));
}

- (void)sendMsg:(NSString *)test{
    
    NSLog(@"Runtime函数调用:%@",test);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
