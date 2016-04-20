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

@interface FavourotePageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FavouritePageTableViewModel *viewModel;

@end

@implementation FavourotePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        
        // 登陆了
        
        
        // 如果之前有数据就跳过
        
        // 没有数据就去请求
        
    } else {
        
        // 没登录就提示未登录，并且清空之前的数据
        
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
