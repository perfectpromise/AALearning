//
//  RegularExpressionCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import "RegularExpressionCtrl.h"

@interface RegularExpressionCtrl ()

@end

@implementation RegularExpressionCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*谓语NSPredicate的用法*/
    [self predicateTest];
    
    /*苹果NSRegularExpression用法*/
    [self regularExpression];
}

/*
 只有在正则表达式为^表达式$时才使用谓词，而不是所有情况都使用
 */
- (void)predicateTest{
    /*熟悉谓语*/
    NSArray *placeArr = [[NSArray alloc]initWithObjects:@"Beijing",@"Shanghai",@"Guangzou",@"Wuhan",@"Taishan", nil];;

    /*
     1、从数组中筛选出包含ang字符串对象,用户数据筛选
     */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"ang"];
    NSArray *resultArr = [placeArr filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL *_Nonnull stop){
        
        NSLog(@"谓语包含测试 = %@",obj);
    }];
    
    /*
     2、两个数组求交集
     */
    NSArray *numberArr1 = [NSArray arrayWithObjects:@1,@2,@5,@6,@7,@3,@5, nil];
    NSArray *numberArr2 = [NSArray arrayWithObjects:@4,@5, nil];
    
    predicate = [NSPredicate predicateWithFormat:@"SELF in %@",numberArr1];
    resultArr = [numberArr2 filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL *_Nonnull stop){
        
        NSLog(@"交集 = %@",obj);
    }];
    
    /*
     3、比较功能：比较运算符>,<,==,>=,<=,!=
     可用于数值及字符串
     */
    predicate = [NSPredicate predicateWithFormat:@"SELF >4"];
    resultArr = [numberArr1 filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"比较 = %@",obj);
    }];
    
    /*
     4、范围运算符：IN、BETWEEN
     例：@"number BETWEEN {1,5}"
     @"address IN {'shanghai','beijing'}"
     */
    predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {2,5}"];
    resultArr = [numberArr1 filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"范围 = %@",obj);
    }];
    
    /*
     5、字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
     例：@"name CONTAIN[cd] 'ang'"   //包含某个字符串
     @"name BEGINSWITH[c] 'sh'"     //以某个字符串开头
     @"name ENDSWITH[d] 'ang'"      //以某个字符串结束
     注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
     */
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd] 'An' "];
    resultArr = [placeArr filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"字符串相关 == %@",obj);
    }];

    /*
     6、通配符：LIKE
     例：@"name LIKE[cd] '*er*'"
     *代表通配符,Like也接受[cd].
     @"name LIKE[cd] '???er*'"
     */
    predicate = [NSPredicate predicateWithFormat:@"SELF  like '*ai*' "];
    resultArr = [placeArr filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"通配符 == %@",obj);
    }];

    
    /*
     7、字符串本身:SELF
     例：@“SELF == ‘APPLE’"
     */
    predicate = [NSPredicate predicateWithFormat:@"SELF == 'Beijing'"];
    resultArr = [placeArr filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"字符串本身 == %@",obj);
    }];

    /*
     8、正则表达式：MATCHES
     例：NSString *regex = @"^A.+e$";   //以S开头，i结尾
     @"name MATCHES %@",regex
     */
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^S.+i$"];
    resultArr = [placeArr filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"正则表达式 == %@",obj);
    }];
    
    
    /*
     9、占位符
     %K ： 动态传入属性名
     %@ ： 动态设置属性值
     例：@"%K CONTAINS[cd] %@",name,age
     */

    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Zhang San",@"name",
                          @"21",@"age", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Li Si",@"name",
                          @"20",@"age", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"Wang Wu",@"name",
                          @"30",@"age", nil];
    NSArray *dicArr = @[dic1,dic2,dic3];
    NSString * name = @"age";
    NSString * age = @"2";
    predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",name,age];
    resultArr = [dicArr filteredArrayUsingPredicate:predicate];
    [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"占位符 == %@",obj);
    }];
    
    //name中包含$SUBSTR的字串
    predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] $SUBSTR",@"name"];
    //指定$SUBSTR的值为sun
    NSPredicate * predicate1 = [predicate predicateWithSubstitutionVariables:@{@"SUBSTR":@"Wang Wu"}];
    resultArr = [dicArr filteredArrayUsingPredicate:predicate1];
    [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"NSPredicate指定 == %@",obj);
    }];
    
    NSPredicate * predicate2 = [predicate predicateWithSubstitutionVariables:[NSDictionary dictionaryWithObjectsAndKeys:@"ang",@"SUBSTR", nil]];
    resultArr = [dicArr filteredArrayUsingPredicate:predicate2];
    [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"NSDictionary指定 == %@",obj);
    }];
    
    /*
     10、
     AND、&&：逻辑与，要求两个表达式的值都为YES时，结果才为YES。
     OR、||：逻辑或，要求其中一个表达式为YES时，结果就是YES
     NOT、 !：逻辑非，对原有的表达式取反
     ANY、SOME：集合中任意一个元素满足条件，就返回YES。
     ALL：集合中所有元素都满足条件，才返回YES。
     NONE：集合中没有任何元素满足条件就返回YES。如:NONE person.age < 18，表示person集合中所有元素的age>=18时，才返回YES。
     IN：等价于SQL语句中的IN运算符，只有当左边表达式或值出现在右边的集合中才会返回YES。
     NULL、NIL：代表空值
     十六进制数：0x开头的数字
     八进制：0o开头的数字
     二进制：0b开头的数字
     
     下列单词都是保留字（不论大小写）：
     AND、OR、IN、NOT、ALL、ANY、SOME、NONE、LIKE、CASEINSENSITIVE、CI、MATCHES、CONTAINS、BEGINSWITH、ENDSWITH、BETWEEN、NULL、NIL、SELF、TRUE、YES、FALSE、NO、FIRST、LAST、SIZE、ANYKEY、SUBQUERY、CAST、TRUEPREDICATE、FALSEPREDICATE
     */
}

#define KPhoneRegex  @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}"
#define KWebRegex    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
#define KWebOtherRegex @"http+:[^\\s]*"
#define KEmailRegex  @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
- (void)regularExpression{
    
    // 测试字符串，把里面的电话号码解析出来
    NSString *urlString = @"哈哈哈哈呵呵呵s15279107723在这里啊啊啊啊s15279107716";
    NSError *error = NULL;
    // 根据匹配条件,创建了一个正则表达式(类方法,实例方法类似)
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:KPhoneRegex options:NSRegularExpressionCaseInsensitive error:&error];
    if (regex != nil) {
        // 3.....
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString
                                                             options:0
                                                               range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString中截取数据
            NSString *result = [urlString substringWithRange:resultRange];
            NSLog(@"result = %@",result);
        }
        // 2.....
        NSUInteger number = [regex numberOfMatchesInString:urlString
                                                   options:0
                                                     range:NSMakeRange(0, [urlString length])];
        NSLog(@"number = %ld",number);
        // 5.....(坑爹的返回第一个匹配结果)
        [regex enumerateMatchesInString:urlString options:0 range:NSMakeRange(0, [urlString length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSLog(@"---%@",NSStringFromRange([result range]));
            if (flags != NSMatchingInternalError) {
                NSRange firstHalfRange = [result rangeAtIndex:0];
                if (firstHalfRange.length > 0) {
                    NSString *resultString1 = [urlString substringWithRange:firstHalfRange];
                    NSLog(@"result1 = %@",resultString1);
                }
            }
            *stop = YES;
        }];
    }
    
    // 替换掉你要匹配的字符串
    NSString *reString = [regex stringByReplacingMatchesInString:urlString
                                                         options:0
                                                           range:NSMakeRange(0, [urlString length])
                                                    withTemplate:@"(我就是替换的值)"];
    NSLog(@"reString = %@",reString);
    // 还有2个方法大家可以去尝试看看
    
    
    // 1.
    NSMutableArray *oneArray = [self _matchLinkWithStr:urlString
                                          withMatchStr:KPhoneRegex];
    for (NSString *phone in oneArray) {
        NSLog(@"phone = %@",phone);
    }
}

- (NSMutableArray *)_matchLinkWithStr:(NSString *)str withMatchStr:(NSString *)matchRegex;
{
    NSError *error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:matchRegex
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
    NSArray *match = [reg matchesInString:str
                                  options:NSMatchingReportCompletion
                                    range:NSMakeRange(0, [str length])];
    
    NSMutableArray *rangeArr = [NSMutableArray array];
    // 取得所有的NSRange对象
    if(match.count != 0)
    {
        for (NSTextCheckingResult *matc in match)
        {
            NSRange range = [matc range];
            NSValue *value = [NSValue valueWithRange:range];
            [rangeArr addObject:value];
        }
    }
    // 将要匹配的值取出来,存入数组当中
    __block NSMutableArray *mulArr = [NSMutableArray array];
    [rangeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSValue *value = (NSValue *)obj;
        NSRange range = [value rangeValue];
        [mulArr addObject:[str substringWithRange:range]];
    }];
    return mulArr;
}

/**
 1. 返回所有匹配结果的集合(适合,从一段字符串中提取我们想要匹配的所有数据)
 *  - (NSArray *)matchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
 2. 返回正确匹配的个数(通过等于0,来验证邮箱,电话什么的,代替NSPredicate)
 *  - (NSUInteger)numberOfMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
 3. 返回第一个匹配的结果。注意，匹配的结果保存在  NSTextCheckingResult 类型中
 *  - (NSTextCheckingResult *)firstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
 4. 返回第一个正确匹配结果字符串的NSRange
 *  - (NSRange)rangeOfFirstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
 5. block方法
 *  - (void)enumerateMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range usingBlock:(void (^)(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop))block;
 */

/**
 *  enum {
 NSRegularExpressionCaseInsensitive             = 1 << 0,   // 不区分大小写的
 NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1,   // 忽略空格和# -
 NSRegularExpressionIgnoreMetacharacters        = 1 << 2,   // 整体化
 NSRegularExpressionDotMatchesLineSeparators    = 1 << 3,   // 匹配任何字符，包括行分隔符
 NSRegularExpressionAnchorsMatchLines           = 1 << 4,   // 允许^和$在匹配的开始和结束行
 NSRegularExpressionUseUnixLineSeparators       = 1 << 5,   // (查找范围为整个的话无效)
 NSRegularExpressionUseUnicodeWordBoundaries    = 1 << 6    // (查找范围为整个的话无效)
 };
 typedef NSUInteger NSRegularExpressionOptions;
 */

// 下面2个枚举貌似都没什么意义,除了在block方法中,一般情况下,直接给0吧
/**
 *  enum {
 NSMatchingReportProgress         = 1 << 0,
 NSMatchingReportCompletion       = 1 << 1,
 NSMatchingAnchored               = 1 << 2,
 NSMatchingWithTransparentBounds  = 1 << 3,
 NSMatchingWithoutAnchoringBounds = 1 << 4
 };
 typedef NSUInteger NSMatchingOptions;
 */

/** 此枚举值只在5.block方法中用到
 *  enum {
 NSMatchingProgress               = 1 << 0,
 NSMatchingCompleted              = 1 << 1,
 NSMatchingHitEnd                 = 1 << 2,
 NSMatchingRequiredEnd            = 1 << 3,
 NSMatchingInternalError          = 1 << 4
 };
 typedef NSUInteger NSMatchingFlags;
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
