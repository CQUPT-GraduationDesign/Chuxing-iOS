//
//  ContactsViewModel.m
//  出行
//
//  Created by 李鑫 on 16/3/21.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "ContactsViewModel.h"

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
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

@end
