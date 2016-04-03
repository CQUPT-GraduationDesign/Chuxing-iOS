//
//  ContactsViewModel.m
//  出行
//
//  Created by 李鑫 on 16/3/21.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "ContactsViewModel.h"
#import "LXNetworkKit.h"
#import "LXNetworkKit+Login.h"
#import <Security/Security.h>
#import "User.h"

@interface ContactsViewModel()

@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;

@end

@implementation ContactsViewModel

- (instancetype)init {
    
    if (self) {
        self = [super init];
    }
    
    
    return self;
}


- (void)initialize {

    void(^doNext)(User *user) = ^(User *user) {
        
        // 存储用户信息，并且跳转页面
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"isLogin"];
        [userDefaults setObject:user.name forKey:@"userName"];
        [userDefaults setObject:user.email forKey:@"userEmail"];
        [userDefaults setObject:user.token forKey:@"userToken"];
        
        [userDefaults synchronize];
        
        
        // TODO: - 跳转
        
        
    };
    
    
    self.validLoginSignal = [[RACSignal
                             combineLatest:@[RACObserve(self, username), RACObserve(self, password)]
                             reduce:^(NSString *username, NSString *password) {
                                 return @(username.length > 0 && password.length > 0);
                             }] distinctUntilChanged];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *password) {
        
        return [[[[LXNetworkKit sharedInstance] loginWithUsername:_username password:_password]
        filter:^BOOL(User *user) { // 判断是否有user
            return user != nil;
        }]
        doNext:doNext];
    }];
    
    
    
}



@end
