//
//  SearchResultTableViewModel.m
//  出行
//
//  Created by 李鑫 on 16/4/12.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "SearchResultTableViewModel.h"
#import "SearchResultModel.h"

@interface SearchResultTableViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation SearchResultTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self)
        return [[[self requestRemoteDataWithPage:self.page] filter:^BOOL(SearchResultModel *model) {
            
            return model != nil;
        }] map:^id(SearchResultModel *model) {
            if (self.page == 0) {
                self.dataSource = model.data;
            } else {
                self.dataSource = [self.dataSource arrayByAddingObjectsFromArray:model.data];
            }
            
            return model;
        }];
    }];
    
}

- (RACSignal *)requestRemoteDataWithPage:(NSInteger)page {
    
    return [[LXNetworkKit sharedInstance] searchWithFromCity:self.fromCityID toCity:self.toCityID withType:self.type withPage:self.page withCount: self.perPage];
}


@end
