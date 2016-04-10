//
//  SearchResultViewController.m
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultTableViewController.h"
#import <Masonry/Masonry.h>

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabedSlideView = [[DLTabedSlideView alloc] init];
    self.tabedSlideView.delegate = self;
    [self.view addSubview:self.tabedSlideView];
    UIEdgeInsets padding = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.tabedSlideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    //self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    self.tabedSlideView.backgroundColor = [UIColor whiteColor];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"默认" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"总时间" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"火车上时间" image:nil selectedImage:nil];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"换乘时间" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3, item4];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
}

#pragma mark - DLTabedSlideViewDelegate

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 4;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            SearchResultTableViewController *ctrl = [[SearchResultTableViewController alloc] init];
            ctrl.dataSource = self.dataSource;
            
            return ctrl;
        }
        case 1:
        {
            SearchResultTableViewController *ctrl = [[SearchResultTableViewController alloc] init];
            
            return ctrl;
        }
        case 2:
        {
            SearchResultTableViewController *ctrl = [[SearchResultTableViewController alloc] init];
            return ctrl;
        }
        case 3:
        {
            SearchResultTableViewController *ctrl = [[SearchResultTableViewController alloc] init];
            return ctrl;
        }
            
        default:
            return nil;
    }
}

@end
