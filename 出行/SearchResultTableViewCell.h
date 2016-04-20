//
//  SearchResultTableViewCell.h
//  出行
//
//  Created by 李鑫 on 16/4/10.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fromCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCityLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstTrainNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *enfTrainNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *startDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitingDurationLabel;

@end
