//
//  LXNetworkKit+Login.m
//  出行
//
//  Created by 李鑫 on 16/3/23.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXNetworkKit+Login.h"
#import "User.h"


@implementation LXNetworkKit (Login)

- (RACSignal *)registerWithUsername:(NSString *)username password:(NSString *)password {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSDictionary *dic = @{@"username": username, @"password": password};
        
        
        [SVProgressHUD show];
        [[AFHTTPSessionManager manager] POST:@"http://go.king-liu.net/api/index.php/user/register" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:responseObject];
            
            NSString *str = [dic objectForKey:@"message"];
            NSNumber *code = [dic objectForKey:@"code"];
            
            if ([code isEqual:@(200)]) {
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"成功" description:str type:TWMessageBarMessageTypeSuccess];
                
                [subscriber sendNext:@(YES)];
                [subscriber sendCompleted];
                
            } else {
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"失败" description:str type:TWMessageBarMessageTypeError];
                
                [subscriber sendNext:@(NO)];
                [subscriber sendCompleted];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"失败" description:[error localizedDescription] type:TWMessageBarMessageTypeError];
            
            [subscriber sendNext:@(NO)];
            [subscriber sendError:nil];
            
        }];

        return [RACDisposable disposableWithBlock:^{
            NSLog(@"dispos");
        }];
        
    }];
    
    
}


- (RACSignal *)loginWithUsername:(NSString *)username password:(NSString *)password {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSDictionary *dic = @{@"username": username, @"password": password};
        
        [SVProgressHUD show];
        [[AFHTTPSessionManager manager] POST:@"http://go.king-liu.net/api/index.php/user/login" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            
            User *currentUser = [[User alloc] init];
            
            
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:responseObject];
            
            NSString *str = [dic objectForKey:@"message"];
            NSNumber *code = [dic objectForKey:@"code"];
            NSString *token = [dic objectForKey:@"access_token"];
            
            [currentUser setToken:token];
            
            NSString *data = [dic objectForKey:@"data"];
            if (data) {
                NSDictionary *dataDic = [[NSDictionary alloc] initWithDictionary:responseObject];
                
                NSString *name = [dataDic objectForKey:@"name"];
                NSString *email = [dataDic objectForKey:@"email"];
                
                [currentUser setName:name];
                [currentUser setEmail:email];
                
            }
            
            
            
            if ([code isEqual:@(200)]) {
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"成功" description:str type:TWMessageBarMessageTypeSuccess];
                
                [subscriber sendNext:currentUser];
                
            } else {
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"失败" description:str type:TWMessageBarMessageTypeError];
                
                [subscriber sendCompleted];
            }
            
            [subscriber sendCompleted];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"失败" description:[error localizedDescription] type:TWMessageBarMessageTypeError];
        }];

        
        
        return nil;
        
    }];
    
}



@end
