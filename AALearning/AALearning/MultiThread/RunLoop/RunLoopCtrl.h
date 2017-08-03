/*
 http://www.jianshu.com/p/d260d18dd551
 RunLoop实际上是一个对象，这个对象在循环中用来处理程序运行过程中出现的各种事件（比如说触摸事件、UI刷新事件、定时器事件、Selector事件），从而保持程序的持续运行；
 而且在没有事件处理的时候，会进入睡眠模式，从而节省CPU资源，提高程序性能。
 
 1、一条线程对应一个RunLoop对象，每条线程都有唯一一个与之对应的RunLoop对象。
 2、我们只能在当前线程中操作当前线程的RunLoop，而不能去操作其他线程的RunLoop。
 3、RunLoop对象在第一次获取RunLoop时创建，销毁则是在线程结束的时候。
 4、主线程的RunLoop对象系统自动帮助我们创建好了(原理如下)，而子线程的RunLoop对象需要我们主动创建。
 
 
 */

#import "BaseViewController.h"

@interface RunLoopCtrl : BaseViewController

@end
