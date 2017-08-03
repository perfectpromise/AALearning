/*
 1、Autorelease Pool 的实现原理：http://blog.leichunfeng.com/blog/2015/05/31/objective-c-autorelease-pool-implementation-principle/  
 2、Runtime源码：https://github.com/RetVal/objc-runtime  https://www.zhihu.com/question/33634266
 */

#import "BaseViewController.h"

@interface RuntimeCtrl : BaseViewController

@end

/*
 class与meta-class:
 核心规则：类的实例对象的 isa 指向该类;该类的 isa 指向该类的 metaclass。
 通俗说法：成员方法记录在class method-list中，类方法记录在meta-class中。即instance-object的信息在class-object中，而class-object的信息在meta-class中。
 */
