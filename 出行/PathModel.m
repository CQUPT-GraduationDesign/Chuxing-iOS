//
//  PathModel.m
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "PathModel.h"

@implementation PathModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"fromCityName" : @"fromcityname",
             @"toCityName" : @"tocityname",
             @"startPath" : @"startData",
             @"middlePath" : @"middleData"};
}

@end
