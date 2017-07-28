//
//  RespBase.h
//  BeadWallet
//
//  Created by LWF on 17/7/20.
//  Copyright © 2017年 贾富珍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespBase : NSObject<NSCoding>

@property (assign,nonatomic) int code;//000:成功  111:失败  222:内部异常  333:第三方服务异常
@property (strong,nonatomic) NSString *msg;

@end
