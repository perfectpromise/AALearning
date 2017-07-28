/*
 1、不规则图形的点击事件，或者扩大缩小点击范围；
 2、Tarbar中间那个凸起的按钮我感觉用这个也可以实现(这个我自己没试过) ，只要重写pointInside:withEvent:方法就行了。
 3、atomic和nonatomic区别：
    atomic原子型：默认的（线程安全，自动加上@synchronized锁来保障线程安全），保证 CPU 能在别的线程来访问这个属性之前，先执行完当前流程
    nonatomic效率高、线程不安全（如有两个线程访问同一个属性，会出现无法预料的结果）
 4、 __block 与 __weak的区别理解 ：__block强引用，在block中容易出现循环引用，__weak弱引用.http://www.cnblogs.com/yajunLi/p/6203222.html?utm_source=itdadao&utm_medium=referral
 */

#import <UIKit/UIKit.h>

@interface ResponderChainCtrl : UIViewController

@end
