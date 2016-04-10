//
//  SearchResultViewController.h
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"

@interface SearchResultViewController : UIViewController<DLTabedSlideViewDelegate>

@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) DLTabedSlideView *tabedSlideView;

@end
