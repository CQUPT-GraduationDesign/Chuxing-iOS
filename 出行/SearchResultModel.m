//
//  SearchResultModel.m
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : PathModel.class};
}

@end
