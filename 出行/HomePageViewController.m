//
//  HomePageViewController.m
//  出行
//
//  Created by 李鑫 on 16/3/18.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "HomePageViewController.h"
#import "ContactsPageViewController.h"
#import "HomePageViewModel.h"
#import "TLCityPickerController.h"

@interface HomePageViewController () <TLCityPickerDelegate>

@property (nonatomic, strong) HomePageViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIView *fromLocation;
@property (weak, nonatomic) IBOutlet UIView *toLocation;
@property (weak, nonatomic) IBOutlet UIImageView *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UILabel *fromCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCityLabel;

@property (nonatomic, assign) BOOL isFromBtn;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindViewModel];
    
    
    self.searchBtn.layer.cornerRadius = 5;
    self.searchBtn.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapFrom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fromTapped)];
    [self.fromLocation addGestureRecognizer:tapFrom];
    
    UITapGestureRecognizer *tapTo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTapped)];
    [self.toLocation addGestureRecognizer:tapTo];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fromTapped {
    
    self.isFromBtn = YES;
    
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    
    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];

    
}

- (void)toTapped {
    
    self.isFromBtn = NO;
    
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    
    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    //[self.navigationController pushViewController:cityPickerVC animated:YES];
    //[self.navigationController presentViewController:cityPickerVC animated:YES completion:nil];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{

    }];
    
}



- (void)bindViewModel {
    
    if (self.viewModel == nil) {
        self.viewModel = [[HomePageViewModel alloc] init];
    }
    
    [RACObserve(self.viewModel, fromCity) subscribeNext:^(NSString *str) {
        [self.fromCityLabel setText:str];
    }];
    [RACObserve(self.viewModel, toCity) subscribeNext:^(NSString *str) {
        [self.toCityLabel setText:str];
    }];
    
}

#pragma mark - TLCityPickerDelegate

- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController
                didSelectCity:(TLCity *)city {
    
    if (self.isFromBtn) {
        
        self.viewModel.fromCity = [city cityName];
        
    } else {
        
        self.viewModel.toCity = [city cityName];
    }
    
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController {
    
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
