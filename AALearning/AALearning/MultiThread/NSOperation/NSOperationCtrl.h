/*
 http://www.jianshu.com/p/4b1d77054b35

 - (void)cancel; NSOperation提供的方法，可取消单个操作
 - (void)cancelAllOperations; NSOperationQueue提供的方法，可以取消队列的所有操作
 - (void)setSuspended:(BOOL)b; 可设置任务的暂停和恢复，YES代表暂停队列，NO代表恢复队列
 - (BOOL)isSuspended; 判断暂停状态
 
 这里的暂停和取消并不代表可以将当前的操作立即取消，而是当当前的操作执行完毕之后不再执行新的操作
 暂停和取消的区别就在于：暂停操作之后还可以恢复操作，继续向下执行；而取消操作之后，所有的操作就清空了，无法再接着执行剩下的操作
 */

#import "BaseViewController.h"

@interface NSOperationCtrl : BaseViewController

@end
