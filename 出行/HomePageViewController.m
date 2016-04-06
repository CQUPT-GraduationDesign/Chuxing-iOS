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

@interface HomePageViewController ()

@property (nonatomic, strong) HomePageViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIView *fromLocation;
@property (weak, nonatomic) IBOutlet UIView *toLocation;
@property (weak, nonatomic) IBOutlet UIImageView *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UILabel *fromCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCityLabel;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindViewModel];
    
    
    self.searchBtn.layer.cornerRadius = 5;
    self.searchBtn.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fromTapped)];
    [self.fromLocation addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fromTapped {
    
    UIViewController *view = [[UIStoryboard storyboardWithName:@"ContactsPage" bundle:nil] instantiateViewControllerWithIdentifier:@"ContactsPageViewController"];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (void)toTapped {
    
    
    
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

@end
