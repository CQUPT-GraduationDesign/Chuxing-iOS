//
//  HomePageViewModel.m
//  出行
//
//  Created by 李鑫 on 16/4/6.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "HomePageViewModel.h"
#import "TLCity.h"
#import "LXNetworkKit+Search.h"

@interface HomePageViewModel()

@property(nonatomic, strong, readwrite) RACCommand *fromCityTappedCommand;
@property(nonatomic, strong, readwrite) RACCommand *toCityTappedCommand;
@property(nonatomic, strong, readwrite) RACCommand *exchangeCommand;
@property(nonatomic, strong, readwrite) RACCommand *searchCommand;



@end

@implementation HomePageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    
    self.fromCity = [[TLCity alloc] init];
    self.fromCity.cityID = @"100010000";
    self.fromCity.cityName = @"北京市";
    self.toCity = [[TLCity alloc] init];
    self.toCity.cityID = @"900010000";
    self.toCity.cityName = @"重庆市";
    
    
    self.exchangeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        TLCity *tmpCity = self.fromCity;
        self.fromCity = self.toCity;
        self.toCity = tmpCity;
        
        return [RACSignal empty];

    }];
    
    self.fromCityTappedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendCompleted];
            return nil;
        }];
        
    }];
    
    self.toCityTappedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendCompleted];
            return nil;
        }];
        
    }];
    
    self.searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [[LXNetworkKit sharedInstance] searchWithFromCity:self.fromCity.cityID toCity:self.toCity.cityID withType:1 withPage:1 withCount: 20];
        
    }];
    
    
    
}


@end
