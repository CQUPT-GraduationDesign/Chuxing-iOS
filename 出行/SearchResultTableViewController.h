//
//  SearchResultTableViewController.h
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PathModel.h"
#import "SearchResultTableViewModel.h"


@interface SearchResultTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) SearchResultTableViewModel *viewModel;

@end
