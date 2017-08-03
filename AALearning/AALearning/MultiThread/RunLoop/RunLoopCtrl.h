/*
 http://www.jianshu.com/p/d260d18dd551
 RunLoop实际上是一个对象，这个对象在循环中用来处理程序运行过程中出现的各种事件（比如说触摸事件、UI刷新事件、定时器事件、Selector事件），从而保持程序的持续运行；
 而且在没有事件处理的时候，会进入睡眠模式，从而节省CPU资源，提高程序性能。
 
 1、一条线程对应一个RunLoop对象，每条线程都有唯一一个与之对应的RunLoop对象。
 2、我们只能在当前线程中操作当前线程的RunLoop，而不能去操作其他线程的RunLoop。
 3、RunLoop对象在第一次获取RunLoop时创建，销毁则是在线程结束的时候。
 4、主线程的RunLoop对象系统自动帮助我们创建好了(原理如下)，而子线程的RunLoop对象需要我们主动创建。
 
 系统默认定义了多种运行模式（CFRunLoopModeRef）
 1、kCFRunLoopDefaultMode：App的默认运行模式，通常主线程是在这个运行模式下运行
 2、UITrackingRunLoopMode：跟踪用户交互事件（用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他Mode影响）
 3、UIInitializationRunLoopMode：在刚启动App时第进入的第一个 Mode，启动完成后就不再使用
 4、GSEventReceiveRunLoopMode：接受系统内部事件，通常用不到
 5、kCFRunLoopCommonModes：伪模式，不是一种真正的运行模式（后边会用到）
 其中kCFRunLoopDefaultMode、UITrackingRunLoopMode、kCFRunLoopCommonModes是我们开发中需要用到的模式
 
 CFRunLoopTimerRef是定时源（RunLoop模型图中提到过），理解为基于时间的触发器，基本上就是NSTimer
 
 
 */

#import "BaseViewController.h"

@interface RunLoopCtrl : BaseViewController

@end
