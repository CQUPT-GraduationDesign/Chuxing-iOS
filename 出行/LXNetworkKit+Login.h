//
//  LXNetworkKit+Login.h
//  出行
//
//  Created by 李鑫 on 16/3/23.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXNetworkKit.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LXNetworkKit (Login)

- (RACSignal *)registerWithUsername:(NSString *)username password:(NSString *)password;

@end
