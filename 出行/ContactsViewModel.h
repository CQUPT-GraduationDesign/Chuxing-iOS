//
//  ContactsViewModel.h
//  出行
//
//  Created by 李鑫 on 16/3/21.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXViewModel.h"

@interface ContactsViewModel : LXViewModel

@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *password;

@property(nonatomic, strong, readonly) RACSignal *validLoginSignal;
@property(nonatomic, strong, readonly) RACCommand *loginCommand;

- (void)initialize;


@end
