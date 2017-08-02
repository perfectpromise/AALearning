//
//  ViewController.m
//  AALearning
//
//  Created by LWF on 17/7/27.
//
//

#import "ViewController.h"
#import "MethodSwizzlingCtrl.h"
#import "ResponderChainCtrl.h"
#import "RuntimeCtrl.h"
#import "NSObject+Property.h"

typedef enum {
    kMethodSwizzling = 0,     //方法交换
    kResponderChain,
    kRuntime,
    
}LearnedType;


@interface ViewController ()
{
    NSArray *learnedArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"首页";
    
    learnedArr = [NSArray arrayWithObjects:@"MethodSwizzling",@"ResponderChain",@"Runtime",
                  @"RegularExpression",@"KVO",@"GCD", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *titleStr = learnedArr[indexPath.row];
    
    NSString *classStr = [NSString stringWithFormat:@"%@Ctrl",titleStr];
    
    //获取类名
    Class tmpCtrl = NSClassFromString(classStr);
    
    //根据类名，动态创建对象
    UIViewController *runtimrCtrl = [tmpCtrl new];
    runtimrCtrl.navigationItem.title = learnedArr[indexPath.row];
    [self.navigationController pushViewController:runtimrCtrl animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return learnedArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"LearnedCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = learnedArr[indexPath.row];
    
    return cell;
}


@end
