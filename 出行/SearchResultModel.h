//
//  SearchResultModel.h
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PathModel.h"

@interface SearchResultModel : NSObject

@property(nonatomic, assign) NSInteger code;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, copy) NSMutableArray<PathModel *> *data;


@end
