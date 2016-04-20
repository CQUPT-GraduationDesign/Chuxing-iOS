//
//  LXUtil.h
//  出行
//
//  Created by 李鑫 on 16/3/28.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXUtil : NSObject

+ (void)cleanUserInfo;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

+ (NSArray *)getHotCityID;

+ (NSString *)getCurrentCityID;

+ (NSString *)transferSecondsToString:(NSTimeInterval)seconds;

@end
