//
//  FavouritePageTableViewModel.m
//  出行
//
//  Created by 李鑫 on 16/4/15.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "FavouritePageTableViewModel.h"
#import "LXNetworkKit+Favourite.h"
#import "SearchResultModel.h"

@interface FavouritePageTableViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation FavouritePageTableViewModel

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
                self.dataSource = (NSMutableArray *)[model.data mutableCopy];
            } else {
                self.dataSource = [[self.dataSource arrayByAddingObjectsFromArray:model.data] mutableCopy];
            }
            
            return model;
        }];
    }];
    
    
}


- (RACSignal *)requestRemoteDataWithPage:(NSInteger)page {
    
    return [[LXNetworkKit sharedInstance] fetchFavouriteList];
}


@end
