//
//  PathModel.h
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubPathModel.h"


@interface PathModel : NSObject

@property(nonatomic, copy) NSString *fromCityName;
@property(nonatomic, copy) NSString *toCityName;

@property(nonatomic, assign) NSTimeInterval transferSeconds;
@property(nonatomic, assign) NSTimeInterval onTrainDuration;
@property(nonatomic, assign) NSTimeInterval wholeDuration;

@property(nonatomic, strong) SubPathModel *startPath;
@property(nonatomic, strong) SubPathModel *middlePath;

@end
