//
//  HomePageViewModel.h
//  出行
//
//  Created by 李鑫 on 16/4/6.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXViewModel.h"

@class TLCity;

@interface HomePageViewModel : LXViewModel

@property(nonatomic, strong) TLCity *fromCity;
@property(nonatomic, strong) TLCity *toCity;

@property(nonatomic, strong, readonly) RACCommand *exchangeCommand;
@property(nonatomic, strong, readonly) RACCommand *searchCommand;
@property(nonatomic, strong, readonly) RACCommand *fromCityTappedCommand;
@property(nonatomic, strong, readonly) RACCommand *toCityTappedCommand;

@end
