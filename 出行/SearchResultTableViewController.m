//
//  SearchResultTableViewController.m
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import <Masonry/Masonry.h>
#import "SearchResultTableViewCell.h"
#import "MJRefresh.h"

@interface SearchResultTableViewController()

@property(nonatomic, strong) UITableView *tableView;



@end

@implementation SearchResultTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_viewModel.dataSource) {
        [[self.viewModel.requestRemoteDataCommand execute:nil] subscribeCompleted:^{
            [self.tableView reloadData];
        }];
    }
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview: self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(insets);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib: [UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchResultTableViewCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.viewModel.page = 0;
        [[self.viewModel.requestRemoteDataCommand execute:nil] subscribeCompleted:^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.viewModel.page += 1;
        [[self.viewModel.requestRemoteDataCommand execute:nil] subscribeCompleted:^{
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    
    
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
    
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}


@end
