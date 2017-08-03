/*
 http://www.jianshu.com/p/2d57c72016c6
 http://www.jianshu.com/p/cbaeea5368b1
 http://www.jianshu.com/p/4b1d77054b35
 http://www.jianshu.com/p/d260d18dd551
 
                        并行队列                        串行队列                    主队列
 同步(sync)       (没有开启新线程，串行执行任务)   (没有开启新线程，串行执行任务)      (没有开启新线程，串行执行任务)
 异步(async)       (有开启新线程，并行执行任务) 	(有开启新线程(1条)，串行执行任务)    (没有开启新线程，串行执行任务)
 */

#import <UIKit/UIKit.h>

@interface GCDCtrl : UIViewController

@end
