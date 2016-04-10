//
//  SubPathModel.h
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TransportType) {
    TransportTypeTrain = 1,
    TransportTypePlane
};

@interface SubPathModel : NSObject

@property(nonatomic, copy) NSString *fromCityName;
@property(nonatomic, copy) NSString *toCityName;
// 列车车次
@property(nonatomic, copy) NSString *trainno;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;
@property(nonatomic, copy) NSString *duration;
@property(nonatomic, assign) TransportType type;

@end
