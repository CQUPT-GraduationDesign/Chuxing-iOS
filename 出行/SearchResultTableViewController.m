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

@interface SearchResultTableViewController()

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SearchResultTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview: self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(insets);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib: [UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchResultTableViewCell"];
    
    
}



#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [_dataSource count];
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultTableViewCell *cell = (SearchResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultTableViewCell"];
    
    
    cell.fromCityLabel.text = [_dataSource objectAtIndex:indexPath.row].startPath.fromCityName;
    cell.middleCityLabel.text = [_dataSource objectAtIndex:indexPath.row].startPath.toCityName;
    cell.toCityLabel.text = [_dataSource objectAtIndex:indexPath.row].middlePath.toCityName;
    
    cell.firstTrainNumberLabel.text = [_dataSource objectAtIndex:indexPath.row].startPath.trainno;
    cell.enfTrainNumberLabel.text = [_dataSource objectAtIndex:indexPath.row].middlePath.trainno;
    
    cell.startTimeLabel.text = [_dataSource objectAtIndex:indexPath.row].startPath.startTime;
    cell.middleTimeLabel.text = [_dataSource objectAtIndex:indexPath.row].startPath.endTime;
    cell.endTimeLabel.text = [_dataSource objectAtIndex:indexPath.row].middlePath.endTime;
    
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}


@end
