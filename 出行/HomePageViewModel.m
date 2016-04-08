//
//  HomePageViewModel.m
//  出行
//
//  Created by 李鑫 on 16/4/6.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "HomePageViewModel.h"

@interface HomePageViewModel()


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
    
    self.fromCity = @"北京";
    self.toCity = @"兰州";
    
    
    
    self.exchangeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSString *tmpCity = self.fromCity;
        self.fromCity = self.toCity;
        self.toCity = tmpCity;
        
        return [RACSignal empty];

    }];
    
    
}


@end
