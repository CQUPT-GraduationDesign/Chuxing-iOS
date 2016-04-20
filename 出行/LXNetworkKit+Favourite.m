//
//  LXNetworkKit+Favourite.m
//  出行
//
//  Created by 李鑫 on 16/4/20.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXNetworkKit+Favourite.h"
#import "AFURLRequestSerialization.h"
#import "SearchResultModel.h"
#import "TWMessageBarManager.h"
#import <YYModel/YYModel.h>

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

- (RACSignal *)fetchFavouriteList {
    
    NSString *url = @"http://go.king-liu.net/api/index.php/res/getlist?";
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
        
        
        [SVProgressHUD show];
        [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [SVProgressHUD dismiss];
            //NSLog(@"%@", responseObject);
            
            // 转换json -> Model
            SearchResultModel *model = [SearchResultModel yy_modelWithJSON:responseObject];
            
            if (model.code == 200) {
                [subscriber sendNext:model];
                [subscriber sendCompleted];
            } else {
                
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"失败" description:model.message type:TWMessageBarMessageTypeError];
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"失败" description:[error localizedDescription] type:TWMessageBarMessageTypeError];
            
            [SVProgressHUD dismiss];
            [subscriber sendError:error];
            
            
        }];
        
        return nil;
        
    }];

}


@end
