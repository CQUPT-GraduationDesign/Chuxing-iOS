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

    
    self.validLoginSignal = [[RACSignal
                             combineLatest:@[RACObserve(self, username), RACObserve(self, password)]
                             reduce:^(NSString *username, NSString *password) {
                                 return @(username.length > 0 && password.length > 0);
                             }] distinctUntilChanged];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *password) {
        
        return [[[[LXNetworkKit sharedInstance] loginWithUsername:_username password:_password]
        filter:^BOOL(NSString *token) { // 判断是否有token，如果没有就是登录失败
            return token.length > 0;
        }]
        doNext:^(id x) {
            // 跳转页面，存储用户信息
        }];
    }];
    
    
    
}

@end
