//
//  SubPathModel.m
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "SubPathModel.h"


@implementation SubPathModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"fromCityName" : @"from",
             @"toCityName" : @"to",};
}

@end
