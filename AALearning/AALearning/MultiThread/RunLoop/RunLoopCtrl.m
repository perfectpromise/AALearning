//
//  RunLoopCtrl.m
//  AALearning
//
//  Created by LWF on 17/7/28.
//
//

#import "RunLoopCtrl.h"

@interface RunLoopCtrl ()

@end

@implementation RunLoopCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"运行循环";
    NSArray *btnTitleArr = [NSArray arrayWithObjects:@"",@"",@"",
                            @"",@"",@"",
                            @"",@"",nil];
    [self addButtonsWithTitle:btnTitleArr];
}

- (void)btnPressed:(UIButton *)btn{
    
    if (btn.tag == 0) {

        
    }else if (btn.tag == 1){

        
    }else if (btn.tag == 2){
        
        
    }else if (btn.tag == 3){

        
    }else if (btn.tag == 4){
        
    }else if (btn.tag == 5){
        
    }else if (btn.tag == 6){
        
    }else if (btn.tag == 7){
    }
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
