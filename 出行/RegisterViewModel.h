//
//  RegisterViewModel.h
//  出行
//
//  Created by 李鑫 on 16/3/27.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXViewModel.h"

@interface RegisterViewModel : LXViewModel

@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *password;

@property(nonatomic, strong, readonly) RACSignal *validRegisterSignal;
@property(nonatomic, strong, readonly) RACCommand *registerCommand;

- (void)initialize;

@end
