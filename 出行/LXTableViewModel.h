//
//  LXTableViewModel.h
//  出行
//
//  Created by 李鑫 on 16/4/12.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXViewModel.h"
#import "PathModel.h"

@interface LXTableViewModel : LXViewModel

@property(nonatomic, copy) NSMutableArray<PathModel *> *dataSource;

@property(nonatomic, assign) NSInteger page;
@property(nonatomic, assign) NSInteger perPage;

@property(nonatomic, strong) RACCommand *didSelectedCommand;

@property (nonatomic, strong, readonly) RACCommand *requestRemoteDataCommand;

- (RACSignal *)requestRemoteDataWithPage:(NSInteger)page;

- (void)initialize;

@end
