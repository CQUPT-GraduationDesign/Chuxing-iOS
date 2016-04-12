//
//  SearchResultTableViewModel.h
//  出行
//
//  Created by 李鑫 on 16/4/12.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXTableViewModel.h"
#import "LXNetworkKit+Search.h"
#import "PathModel.h"

@interface SearchResultTableViewModel : LXTableViewModel

@property(nonatomic, copy) NSString *fromCityID;
@property(nonatomic, copy) NSString *toCityID;

@property(nonatomic, assign) SearchType type;

@end
