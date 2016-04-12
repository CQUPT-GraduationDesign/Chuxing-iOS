//  LXTableViewModel.m
//  出行
//
//  Created by 李鑫 on 16/4/12.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXTableViewModel.h"

@interface LXTableViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation LXTableViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize {
    
    self.page = 0;
    self.perPage = 20;
    
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self)
        return [self requestRemoteDataWithPage:self.page];
    }];
    
    
}


- (RACSignal *)requestRemoteDataWithPage:(NSInteger)page {
    return [RACSignal empty];
}


@end
