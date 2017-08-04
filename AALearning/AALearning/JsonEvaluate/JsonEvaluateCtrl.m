//
//  JsonEvaluateCtrl.m
//  AALearning
//
//  Created by LWF on 2017/8/4.
//
//

#import "JsonEvaluateCtrl.h"
#import "GitHubUser.h"

@interface JsonEvaluateCtrl ()

@end

@implementation JsonEvaluateCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Json性能评测";
    
    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"普通Json测试", nil];
    [self addButtonsWithTitle:btnTitleArr];
}

- (void)btnPressed:(UIButton *)btn{
    
    if (btn.tag == 0) {
        /*延时1秒开启测试*/
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self testUserJson];
        });
    }
}

- (void)testUserJson{
    
    /*评测数据初始化*/
    //userJson
    NSString *userPath = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"json"];
    NSData *userData = [NSData dataWithContentsOfFile:userPath];
    NSDictionary *userJson = [NSJSONSerialization JSONObjectWithData:userData options:0 error:nil];
    
    //weiboJson
//    NSString *weiboPath = [[NSBundle mainBundle] pathForResource:@"weibo" ofType:@"json"];
//    NSData *weiboData = [NSData dataWithContentsOfFile:weiboPath];
//    NSDictionary *weiboJson = [NSJSONSerialization JSONObjectWithData:weiboData options:0 error:nil];
    
    /// Benchmark
    int count = 10000;
    NSTimeInterval begin, end;

    /// warm up (NSDictionary's hot cache, and JSON to model framework cache)
    FEMMapping *mapping = [FEGHUser defaultMapping];
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTGHUser class]];
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            // Manually
            [[[[GHUser alloc] initWithJSONDictionary:userJson] description] length];
            
            // YYModel
            [YYGHUser yy_modelWithJSON:userJson];
            
            // FastEasyMapping
            [FEMDeserializer fillObject:[FEGHUser new] fromRepresentation:userJson mapping:mapping];
            
            // JSONModel
            [[[[JSGHUser alloc] initWithDictionary:userJson error:nil] description] length];
            
            // Mantle
            [adapter modelFromJSONDictionary:userJson error:nil];
            
            // MJExtension
            [MJGHUser mj_objectWithKeyValues:userJson];
        }
    }
    /// warm up holder
    NSMutableArray *holder = [NSMutableArray new];
    for (int i = 0; i < 1800; i++) {
        [holder addObject:[NSDate new]];
    }
    [holder removeAllObjects];
    
    /*------------------- Manually -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                GHUser *user = [[GHUser alloc] initWithJSONDictionary:userJson];
                [holder addObject:user];
            }
        }
        end = CACurrentMediaTime();
        printf("Manually:        %8.2f   ", (end - begin) * 1000);
        
        
        GHUser *user = [[GHUser alloc] initWithJSONDictionary:userJson];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user convertToJSONDictionary];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user convertToJSONDictionary]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    /*------------------- YYModel -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                YYGHUser *user = [YYGHUser yy_modelWithJSON:userJson];
                [holder addObject:user];
            }
        }
        end = CACurrentMediaTime();
        printf("YYModel:         %8.2f   ", (end - begin) * 1000);
        
        
        YYGHUser *user = [YYGHUser yy_modelWithJSON:userJson];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user yy_modelToJSONObject];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user yy_modelToJSONObject]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    
    /*------------------- FastEasyMapping -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                FEGHUser *user = [FEGHUser new];
                [FEMDeserializer fillObject:user fromRepresentation:userJson mapping:mapping];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("FastEasyMapping: %8.2f   ", (end - begin) * 1000);
        
        
        FEGHUser *user = [FEGHUser new];
        [FEMDeserializer fillObject:user fromRepresentation:userJson mapping:mapping];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [FEMSerializer serializeObject:user usingMapping:mapping];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject: [FEMSerializer serializeObject:user usingMapping:mapping]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        // FastEasyMapping does not support NSCoding?
        printf("     N/A\n");
    }
    
    /*------------------- JSONModel -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                JSGHUser *user = [[JSGHUser alloc] initWithDictionary:userJson error:nil];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("JSONModel:       %8.2f   ", (end - begin) * 1000);
        
        
        JSGHUser *user = [[JSGHUser alloc] initWithDictionary:userJson error:nil];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user toDictionary];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user toDictionary]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    /*------------------- Mantle -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                MTGHUser *user = [adapter modelFromJSONDictionary:userJson error:nil];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("Mantle:          %8.2f   ", (end - begin) * 1000);
        
        
        MTGHUser *user = [adapter modelFromJSONDictionary:userJson error:nil];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [adapter JSONDictionaryFromModel:user error:nil];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[adapter JSONDictionaryFromModel:user error:nil]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    /*------------------- MJExtension -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                MJGHUser *user = [MJGHUser mj_objectWithKeyValues:userJson];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("MJExtension:     %8.2f   ", (end - begin) * 1000);
        
        
        MJGHUser *user = [MJGHUser mj_objectWithKeyValues:userJson];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user mj_JSONObject];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user mj_JSONObject]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    printf("----------------------\n");
    printf("\n");

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
