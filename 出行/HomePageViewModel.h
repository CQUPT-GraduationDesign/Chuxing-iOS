//
//  HomePageViewModel.h
//  出行
//
//  Created by 李鑫 on 16/4/6.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXViewModel.h"


@interface HomePageViewModel : LXViewModel

@property(nonatomic, copy) NSString *fromCity;
@property(nonatomic, copy) NSString *toCity;

@property(nonatomic, strong, readonly) RACCommand *exchangeCommand;
@property(nonatomic, strong, readonly) RACCommand *searchCommand;

@end
