//
//  FavourotePageViewController.m
//  出行
//
//  Created by 李鑫 on 16/3/18.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "FavourotePageViewController.h"
#import "FavouritePageTableViewModel.h"
#import "LXUtil.h"
#import "LXNetworkKit+Favourite.h"
#import "SearchResultModel.h"
#import "MapViewController.h"
#import "SearchResultTableViewCell.h"
#import "MJRefresh.h"

@interface FavourotePageViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *blankView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FavouritePageTableViewModel *viewModel;

@end

@implementation FavourotePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewModel = [[FavouritePageTableViewModel alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.hidden = YES;
    self.blankView.hidden = YES;
    
    [self.tableView registerNib: [UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchResultTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[self.viewModel.requestRemoteDataCommand execute:nil] subscribeCompleted:^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        
        // 登陆了
        
        // 如果之前有数据就跳过
        if (_viewModel.dataSource) {
            
            
        } else {
            // 没有数据就去请求
            
            [[self.viewModel.requestRemoteDataCommand execute:nil] subscribeCompleted:^{
                [self.tableView reloadData];
                
                [self isShowBlankView:NO];

            }];   
        }
        
        
        
        
    } else {
        
        // 没登录就提示未登录，并且清空之前的数据
        
        [self isShowBlankView:YES];
        _viewModel.dataSource = nil;
        
    }
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [_dataSource count];
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MapViewController *mapView = [[MapViewController alloc] init];
    mapView.start = [_viewModel.dataSource objectAtIndex:indexPath.section].fromCityName;
    mapView.middle = [_viewModel.dataSource objectAtIndex:indexPath.section].startPath.toCityName;
    mapView.end = [_viewModel.dataSource objectAtIndex:indexPath.section].toCityName;
    
    [self.navigationController pushViewController:mapView animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultTableViewCell *cell = (SearchResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultTableViewCell"];
    
    
    cell.fromCityLabel.text = [_viewModel.dataSource objectAtIndex:indexPath.section].startPath.fromCityName;
    cell.middleCityLabel.text = [_viewModel.dataSource objectAtIndex:indexPath.section].startPath.toCityName;
    cell.toCityLabel.text = [_viewModel.dataSource objectAtIndex:indexPath.section].middlePath.toCityName;
    
    cell.firstTrainNumberLabel.text = [_viewModel.dataSource objectAtIndex:indexPath.section].startPath.trainno;
    cell.enfTrainNumberLabel.text = [_viewModel.dataSource objectAtIndex:indexPath.section].middlePath.trainno;
    
    cell.startTimeLabel.text = [_viewModel.dataSource objectAtIndex:indexPath.section].startPath.startTime;
    cell.middleTimeLabel.text = [NSString stringWithFormat:@"%@|%@", [_viewModel.dataSource objectAtIndex:indexPath.section].startPath.endTime, [_viewModel.dataSource objectAtIndex:indexPath.section].middlePath.startTime];
    cell.endTimeLabel.text = [_viewModel.dataSource objectAtIndex:indexPath.section].middlePath.endTime;
    
    cell.startDurationLabel.text = [NSString stringWithFormat:@"历时%@", [_viewModel.dataSource objectAtIndex:indexPath.section].startPath.duration];
    cell.endDurationLabel.text = [NSString stringWithFormat:@"历时%@", [_viewModel.dataSource objectAtIndex:indexPath.section].middlePath.duration];
    cell.waitingDurationLabel.text = [NSString stringWithFormat:@"等待%@", [LXUtil transferSecondsToString: [_viewModel.dataSource objectAtIndex:indexPath.section].transferSeconds]];
    
    
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray *mutable = [self.viewModel.dataSource mutableCopy];
        [mutable removeObjectAtIndex:indexPath.row];
        self.viewModel.dataSource = mutable;
        
        //[self.viewModel.dataSource removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)isShowBlankView:(BOOL)show {
    
    if (show) {
        self.blankView.hidden = NO;
        self.tableView.hidden = YES;
    } else {
        self.blankView.hidden = YES;
        self.tableView.hidden = NO;
    }
    
    
    
}

@end
