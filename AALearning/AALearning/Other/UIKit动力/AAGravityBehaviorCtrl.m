//
//  AAGravityBehaviorCtrl.m
//  AALearning
//
//  Created by WS on 2017/10/25.
//

#import "AAGravityBehaviorCtrl.h"
#import<AVFoundation/AVSpeechSynthesis.h>

@interface AAGravityBehaviorCtrl ()<AVSpeechSynthesizerDelegate>
{
    AVSpeechSynthesizer*av;
}
@end

@implementation AAGravityBehaviorCtrl

- (UIImageView *)square1{
    
    if (!_square1) {
        _square1 = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-250)/2.0, 200.0, 250, 180.0)];
        _square1.image = [UIImage imageNamed:@"ball.jpg"];
    }
    return _square1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"其他";
//    [self.view addSubview:self.square1];
    
    [self addButtonsWithTitle:@[@"开始",@"停止"]];
}
- (void)btnPressed:(UIButton *)btn{
    //子类重写该方法
    if (btn.tag == 0) {
        if([av isPaused]) {
            
            //如果暂停则恢复，会从暂停的地方继续
            [av continueSpeaking];
        }else{
            
            //初始化对象
            av= [[AVSpeechSynthesizer alloc]init];
            av.delegate=self;//挂上代理
            NSString *path = [[NSBundle mainBundle] pathForResource:@"read" ofType:@"txt"];
            NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

//            AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:@"锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。"];//需要转换的文字
            
            AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:content];
            utterance.rate=0.4;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
            AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
            utterance.voice= voice;
            [av speakUtterance:utterance];//开始
        }
    }else{
        //[av stopSpeakingAtBoundary:AVSpeechBoundaryWord];//感觉效果一样，对应代理>>>取消
        [av pauseSpeakingAtBoundary:AVSpeechBoundaryWord];//暂停
    }
    //[utterance release];//需要关闭ARC
    //[av release];
    
    //    if (btn.tag == 0) {
    //        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    //        UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.square1]];
    //        [self.animator addBehavior:gravityBeahvior];
    //    }else{
    //        [self.animator removeAllBehaviors];
    //    }
    
}

@end
