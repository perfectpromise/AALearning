/*
 1、不规则图形的点击事件，或者扩大缩小点击范围；
 2、Tarbar中间那个凸起的按钮我感觉用这个也可以实现(这个我自己没试过) ，只要重写pointInside:withEvent:方法就行了。
 3、atomic和nonatomic区别：
    atomic原子型：默认的（线程安全，自动加上@synchronized锁来保障线程安全），保证 CPU 能在别的线程来访问这个属性之前，先执行完当前流程
    nonatomic效率高、线程不安全（如有两个线程访问同一个属性，会出现无法预料的结果）
 4、 __block 与 __weak的区别理解 ：__block强引用，在block中容易出现循环引用，__weak弱引用.http://www.cnblogs.com/yajunLi/p/6203222.html?utm_source=itdadao&utm_medium=referral
    A:__weak 本身是可以避免循环引用的问题的，但是其会导致外部对象释放了之后，block 内部也访问不到这个对象的问题，我们可以通过在 block 内部声明一个 __strong 的变量来指向 weakObj，使外部对象既能在 block 内部保持住，又能避免循环引用的问题。
    B:__block 本身无法避免循环引用的问题，但是我们可以通过在 block 内部手动把 blockObj 赋值为 nil 的方式来避免循环引用的问题。另外一点就是 __block 修饰的变量在 block 内外都是唯一的，要注意这个特性可能带来的隐患。
    C:但是__block有一点：这只是限制在ARC环境下。在非arc下，__block是可以避免引用循环的
 */

#import <UIKit/UIKit.h>

@interface ResponderChainCtrl : UIViewController

@end
