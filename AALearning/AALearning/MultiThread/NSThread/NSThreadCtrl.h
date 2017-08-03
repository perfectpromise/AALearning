/*
  http://www.jianshu.com/p/cbaeea5368b1
 
 A:如果CPU现在调度当前线程对象，则当前线程对象进入运行状态，如果CPU调度其他线程对象，则当前线程对象回到就绪状态。
 B:如果CPU在运行当前线程对象的时候调用了sleep方法\等待同步锁，则当前线程对象就进入了阻塞状态，等到sleep到时\得到同步锁，则回到就绪状态。
 C:如果CPU在运行当前线程对象的时候线程任务执行完毕\异常强制退出，则当前线程对象进入死亡状态。
 
 */

#import "BaseViewController.h"

@interface NSThreadCtrl : BaseViewController

@end
