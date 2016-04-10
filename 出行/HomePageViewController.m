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
#import "LXUtil.h"
#import "SearchResultViewController.h"
#import "SearchResultModel.h"


@interface HomePageViewController () <TLCityPickerDelegate>

@property (nonatomic, strong) HomePageViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIView *fromLocation;
@property (weak, nonatomic) IBOutlet UIView *toLocation;
@property (weak, nonatomic) IBOutlet UIView *exchangeView;
@property (weak, nonatomic) IBOutlet UILabel *fromCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCityLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

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
    
    UITapGestureRecognizer *tapExchange = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exchangeTapped)];
    [self.exchangeView addGestureRecognizer:tapExchange];
    
    //NSLog(@"%@", [LXUtil getHotCityID]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fromTapped {}

- (void)toTapped {}

- (void)exchangeTapped {}


- (void)bindViewModel {
    
    if (self.viewModel == nil) {
        self.viewModel = [[HomePageViewModel alloc] init];
    }
    
    [RACObserve(self.viewModel, fromCity) subscribeNext:^(TLCity *city) {
        [self.fromCityLabel setText:city.cityName];
    }];
    [RACObserve(self.viewModel, toCity) subscribeNext:^(TLCity *city) {
        [self.toCityLabel setText:city.cityName];
    }];
    
    [[self rac_signalForSelector:@selector(exchangeTapped)] subscribeNext:^(id x) {
        [self.viewModel.exchangeCommand execute:nil];
    }];
    
    [[self rac_signalForSelector:@selector(toTapped)] subscribeNext:^(id x) {
        [[self.viewModel.fromCityTappedCommand execute:nil] subscribeCompleted:^{
            self.isFromBtn = NO;
            
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
            [cityPickerVC setDelegate:self];
            
            cityPickerVC.locationCityID = [LXUtil getCurrentCityID];
            cityPickerVC.hotCitys = [LXUtil getHotCityID];

            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
                
            }];
        }];
    }];
    
    [[self rac_signalForSelector:@selector(fromTapped)] subscribeNext:^(id x) {
        [[self.viewModel.toCityTappedCommand execute:nil]subscribeCompleted:^{
            self.isFromBtn = YES;
            
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
            [cityPickerVC setDelegate:self];
            
            cityPickerVC.locationCityID = [LXUtil getCurrentCityID];
            cityPickerVC.hotCitys = [LXUtil getHotCityID];

            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
                
            }];
        }];
    }];
    
    [[self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[self.viewModel.searchCommand execute:nil] subscribeNext:^(SearchResultModel *model) {
            // 跳转到搜索结果页面
            SearchResultViewController *view = [[SearchResultViewController alloc] init];
            view.dataSource = model.data;
            [self.navigationController pushViewController:view animated:YES];
        }];
    }];
    
    
}

#pragma mark - TLCityPickerDelegate

- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController
                didSelectCity:(TLCity *)city {
    
    if (self.isFromBtn) {
        
        self.viewModel.fromCity = city;
        
    } else {
        
        self.viewModel.toCity = city;
    }
    
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController {
    
    [cityPickerViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
