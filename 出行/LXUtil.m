//
//  LXUtil.m
//  出行
//
//  Created by 李鑫 on 16/3/28.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXUtil.h"

@implementation LXUtil

+ (void)cleanUserInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userName"];
    [userDefaults removeObjectForKey:@"userEmail"];
    [userDefaults removeObjectForKey:@"userToken"];
    [userDefaults setBool:NO forKey:@"isLogin"];
    
}


@end
