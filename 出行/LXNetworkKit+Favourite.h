//
//  LXNetworkKit+Favourite.h
//  出行
//
//  Created by 李鑫 on 16/4/20.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "LXNetworkKit.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LXNetworkKit (Favourite)


- (RACSignal *)favouriteWithPathID:(NSString *)pathID;


@end
