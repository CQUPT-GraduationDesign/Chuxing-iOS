//
//  LXNetworkKit.m
//  出行
//
//  Created by 李鑫 on 16/3/23.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXNetworkKit.h"

static const NSString *baseURL = @"http://go.king-liu.net";

@implementation LXNetworkKit


+ (id)sharedInstance {
    
    static LXNetworkKit *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [HYBNetworking updateBaseUrl: @"http://go.king-liu.net"];
    });
    
    return sharedInstance;
}



@end
