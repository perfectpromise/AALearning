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
#import "NSObject+AAModel.h"
#import "TestModel.h"
#import "TestMsgSend.h"
#import "Monkey.h"
#import "NNValidationView.h"

@interface RuntimeCtrl ()
{
    TestModel *_model;
}
@property (nonatomic, strong) NNValidationView *testView;
@end

@implementation RuntimeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"Runtime(运行时)";

    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"消息发送",@"字典转模型",@"模型转字典",@"动态方法解析", nil];
    [self addButtonsWithTitle:btnTitleArr];
    
    [self setupViews];
}

- (void)setupViews {
    _testView = [[NNValidationView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, 380, 100, 40) andCharCount:4 andLineCount:4];
    [self.view addSubview:_testView];
    
    __weak typeof(self) weakSelf = self;
    /// 返回验证码数字
    _testView.changeValidationCodeBlock = ^(void){
        NSLog(@"验证码被点击了：%@", weakSelf.testView.charString);
    };
    NSLog(@"第一次打印：%@", self.testView.charString);
}

- (void)btnPressed:(UIButton *)btn{
    
    if (btn.tag == 0) {
        [self msgSend];
        
    }else if (btn.tag == 1){
        [self dictinaryToModel];
        
    }else if (btn.tag == 2){
        [self modelToDictinary];
        
    }else if (btn.tag == 3){
        [self msgForward];
    }
}

/*
 消息发送：msgSend
 相当于[self sendMsg:@"test"]，可以传参数、可以有返回值
 */
- (void)msgSend{
    TestMsgSend *msgSend = [TestMsgSend new];
    
    /*无需返回值，不传参数*/
    ((void (*) (id, SEL))objc_msgSend)(msgSend, sel_registerName("showAge"));
    
    /*无需返回值，传入一个NSString类型参数*/
    ((void (*) (id, SEL, NSString *))objc_msgSend)(msgSend, sel_registerName("showName:"),@"安安");
    
    /*无需返回值，传入两个float类型参数*/
    ((void (*) (id, SEL, float, float)) objc_msgSend)(msgSend, sel_registerName("showWeight:andHeight:"),10.0f,80.0f);
    
    /*返回float类型，传入值为空*/
    float height = ((float (*) (id, SEL)) objc_msgSend)(msgSend, sel_registerName("getHeight"));
    
    /*返回NSString类型，不传入参数*/
    NSString *info = ((NSString* (*) (id, SEL)) objc_msgSend)(msgSend, sel_registerName("getInfo"));
    
    NSLog(@"身高：%f CM，基本信息：%@",height,info);
}

/*
  模型和字典相互转换
 */
- (void)dictinaryToModel{
    
    /*字典转模型*/
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"武汉大学",@"name",
                         @"10859",@"count",
                         [NSDictionary dictionaryWithObjectsAndKeys:@"国立图书馆",@"name",
                          @"88888",@"borrowerCount",
                          nil],@"library",
                         [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"东食堂",@"name",nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:@"西食堂",@"name",nil], nil],@"diningRoom",nil];
    
    _model =  [TestModel aa_modelWithDictionary:dic];
    NSLog(@"%@",_model.name);
}

- (void)modelToDictinary{
    /*模型转字典*/
    NSDictionary *modelDic = [_model dictionaryWithModel];
    NSLog(@"%@",modelDic);
}

/*
 动态方法解析
 */
- (void)msgForward{
    /*动态方法解析*/
    Monkey *monkey = [Monkey new];
    objc_msgSend(monkey, sel_registerName("fly"));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
