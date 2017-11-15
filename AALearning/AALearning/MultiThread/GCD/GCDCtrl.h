/*
 http://www.jianshu.com/p/2d57c72016c6
 
                 并行队列(DISPATCH_QUEUE_CONCURRENT)         串行队列(DISPATCH_QUEUE_SERIAL)           主队列(dispatch_get_main_queue)
 同步(sync)           (没有开启新线程，串行执行任务)                (没有开启新线程，串行执行任务)               (没有开启新线程，串行执行任务)
 异步(async)          (有开启新线程，并行执行任务) 	              (有开启新线程(1条)，串行执行任务)            (没有开启新线程，串行执行任务)
 */

#import "BaseViewController.h"

@interface GCDCtrl : BaseViewController

@end
