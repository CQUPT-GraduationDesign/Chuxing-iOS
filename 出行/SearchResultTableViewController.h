//
//  SearchResultTableViewController.h
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *dataSource;

@end
