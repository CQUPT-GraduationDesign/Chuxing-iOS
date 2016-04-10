//
//  LXNetworkKit+Search.h
//  出行
//
//  Created by 李鑫 on 16/4/9.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXNetworkKit.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSInteger, SearchType) {
    // 默认排序
    SearchTypeDefault = 1,
    // 总时间排序
    SearchTypeWhole,
    // 在车上的时间排序
    SearchTypeOnTrain,
    // 按照等待时间排序
    SearchTypeTransfer
};

@interface LXNetworkKit (Search)

- (RACSignal *)searchWithFromCity:(NSString *)fromCityID toCity:(NSString *)toCityID withType:(SearchType)type withPage:(NSInteger)page withCount:(NSInteger)count;

@end
