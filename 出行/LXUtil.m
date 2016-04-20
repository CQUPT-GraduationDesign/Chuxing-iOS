//
//  LXUtil.m
//  出行
//
//  Created by 李鑫 on 16/3/28.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXUtil.h"
#import <SDWebImage/SDWebImageManager.h>
#import "TLCityPicker/TLCity.h"

@implementation LXUtil

+ (void)cleanUserInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userName"];
    [userDefaults removeObjectForKey:@"userEmail"];
    [userDefaults removeObjectForKey:@"userToken"];
    [userDefaults setBool:NO forKey:@"isLogin"];
    
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

+ (NSArray *)getHotCityID {
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
    NSMutableArray *d = [[NSMutableArray alloc] init];
    for (NSDictionary *groupDic in array) {
        TLCityGroup *group = [[TLCityGroup alloc] init];
        group.groupName = [groupDic objectForKey:@"initial"];
        for (NSDictionary *dic in [groupDic objectForKey:@"citys"]) {
            TLCity *city = [[TLCity alloc] init];
            city.cityID = [dic objectForKey:@"city_key"];
            city.cityName = [dic objectForKey:@"city_name"];
            city.shortName = [dic objectForKey:@"short_name"];
            city.pinyin = [dic objectForKey:@"pinyin"];
            city.initials = [dic objectForKey:@"initials"];
            [group.arrayCitys addObject:city];
        }
        [d addObject:group];
    }
    
    
    NSArray *citys = @[@"北京", @"上海", @"天津", @"西安", @"深圳", @"重庆", @"武汉", @"广州", @"成都", @"杭州", @"济南", @"南京", @"郑州", @"长春", @"哈尔滨", @"长沙", @"大连", @"沈阳", @"青岛", @"石家庄", @"南昌", @"合肥", @"福州", @"太原", @"兰州"];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    for (TLCityGroup* group in d) {
        for (TLCity* city in group.arrayCitys) {
            if ([citys containsObject: city.shortName]) {
                
                //NSLog(@"%@ = %@", city.shortName, city.cityID);
                [tmpArray addObject:city.cityID];
            }
        }
    }
    
    //NSLog(@"%@", [dic description]);
    return tmpArray;
    
}


+ (NSString *)getCurrentCityID {
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
    NSMutableArray *d = [[NSMutableArray alloc] init];
    for (NSDictionary *groupDic in array) {
        TLCityGroup *group = [[TLCityGroup alloc] init];
        group.groupName = [groupDic objectForKey:@"initial"];
        for (NSDictionary *dic in [groupDic objectForKey:@"citys"]) {
            TLCity *city = [[TLCity alloc] init];
            city.cityID = [dic objectForKey:@"city_key"];
            city.cityName = [dic objectForKey:@"city_name"];
            city.shortName = [dic objectForKey:@"short_name"];
            city.pinyin = [dic objectForKey:@"pinyin"];
            city.initials = [dic objectForKey:@"initials"];
            [group.arrayCitys addObject:city];
        }
        [d addObject:group];
    }
    
    
    NSArray *citys = @[@"重庆"];
    
    
    for (TLCityGroup* group in d) {
        for (TLCity* city in group.arrayCitys) {
            if ([citys containsObject: city.shortName]) {
                
                return city.cityID;
            }
        }
    }

    // 没找到就返回北京
    return @"100010000";
    
    
}


+ (NSString *)transferSecondsToString:(NSTimeInterval)seconds {
    
    if (seconds < 60) {
        // 1分钟之内
        return [NSString stringWithFormat:@"%.lf秒", seconds];
    } else if (seconds < 60 * 60) {
        // 一小时之内
        int min = seconds / 60;
        return [NSString stringWithFormat:@"%d分钟", min];
    } else if (seconds < 60 * 60 * 60) {
        // 1天之内
        int hour = seconds / 60 / 60;
        int min = (seconds - (hour * 60 * 60)) / 60;
//        /double second = seconds - (min * 60) - (hour * 60 * 60);
        return [NSString stringWithFormat:@"%d小时%d分钟", hour, min];
    }
    
    return @"一天以上";
    
}


@end
