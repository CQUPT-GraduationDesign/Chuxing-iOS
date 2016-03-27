//
//  RegisterViewModel.m
//  出行
//
//  Created by 李鑫 on 16/3/27.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "RegisterViewModel.h"
#import "LXNetworkKit.h"
#import "LXNetworkKit+Login.h"

@interface RegisterViewModel()

@property(nonatomic, strong, readwrite) RACSignal *validRegisterSignal;
@property(nonatomic, strong, readwrite) RACCommand *registerCommand;

@end

@implementation RegisterViewModel


- (instancetype)init {
    
    if (self) {
        self = [super init];
    }
    
    
    return self;
}


- (void)initialize {
    
    
    self.validRegisterSignal = [[RACSignal
                              combineLatest:@[RACObserve(self, username), RACObserve(self, password)]
                              reduce:^(NSString *username, NSString *password) {
                                  return @(username.length > 0 && password.length > 0);
                              }] distinctUntilChanged];
    
    self.registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *password) {
        
        
        return [[LXNetworkKit sharedInstance] registerWithUsername:_username password:_password];
    }];
}



@end
