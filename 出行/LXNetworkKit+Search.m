//
//  LXNetworkKit+Search.m
//  出行
//
//  Created by 李鑫 on 16/4/9.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXNetworkKit+Search.h"
#import <YYModel/YYModel.h>
#import "SearchResultModel.h"
#import "TWMessageBarManager.h"

@implementation LXNetworkKit (Search)

- (RACSignal *)searchWithFromCity:(NSString *)fromCityID toCity:(NSString *)toCityID withType:(SearchType)type withPage:(NSInteger)page withCount:(NSInteger)count {
    
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSDictionary *dic = @{@"from": fromCityID, @"to": toCityID, @"type": [[NSString alloc] initWithFormat:@"%ld", (long)type], @"page": @(page), @"counts": @(count)};
        
        [SVProgressHUD show];
        [[AFHTTPSessionManager manager] POST:@"http://go.king-liu.net/api/index.php/search/train" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [SVProgressHUD dismiss];
            NSLog(@"%@", responseObject);
            
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
