//
//  LXNetworkKit+Favourite.m
//  出行
//
//  Created by 李鑫 on 16/4/20.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXNetworkKit+Favourite.h"
#import "AFURLRequestSerialization.h"

@implementation LXNetworkKit (Favourite)

- (RACSignal *)favouriteWithPathID:(NSString *)pathID {
    
    NSString *url = @"http://go.king-liu.net/api/index.php/res/addcol?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
    if (token && ![token isEqualToString:@""]) {
        
        token = [token stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
        
        url = [url stringByAppendingString:@"access-token="];
        url = [url stringByAppendingString:token];

    } else {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"失败" description:@"请登录后再收藏" type:TWMessageBarMessageTypeError];
        return [RACSignal empty];
    }
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSDictionary *dic = @{@"trainlineid" : pathID};
        
        [SVProgressHUD show];
        
        [[AFHTTPSessionManager manager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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
            [subscriber sendError:error];
            
        }];
        
        
        return nil;
    }];
    
    
    
}

@end
