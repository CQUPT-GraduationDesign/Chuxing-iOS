//
//  ContactsTableViewController.m
//  出行
//
//  Created by 李鑫 on 16/3/28.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "LXUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "LXUtil.h"

@interface ContactsTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (nonatomic, strong)NSUserDefaults *userDefault;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 30;
    
    self.userDefault = [NSUserDefaults standardUserDefaults];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[SDWebImageManager sharedManager].imageDownloader setValue: nil forHTTPHeaderField:@"Accept"];
    
    
    
    if ([self.userDefault boolForKey:@"isLogin"]) {
        [self.userName setText:[self.userDefault objectForKey:@"userName"]];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[@"http://7xr4g8.com1.z0.glb.clouddn.com/" stringByAppendingString:[NSString stringWithFormat:@"%ld", [[self.userDefault objectForKey:@"userID"] integerValue]]]] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            self.userImage.image = [LXUtil reSizeImage:image toSize:CGSizeMake(60, 60)];
        }];
        //[self.userImage sd_setImageWithURL:[NSURL URLWithString:[@"http://7xr4g8.com1.z0.glb.clouddn.com/" stringByAppendingString:[NSString stringWithFormat:@"%d", arc4random() % 900]]]];
    } else {
        [self.userName setText:@"未登录"];
        self.userImage.image = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([indexPath section] == 0) { // 点击的是头像
        if ([self.userDefault boolForKey:@"isLogin"]) {
            // 查看头像或者啥都不干
        } else {
            // 跳转到登陆页面
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ContactsPage" bundle:[NSBundle mainBundle]];
            UIViewController *view = [storyBoard instantiateViewControllerWithIdentifier:@"ContactsPageViewController"];
            
            //[self presentViewController:view animated:YES completion:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
    
    if ([indexPath section] == 2) { // 退出登陆
        
        if (![self.userDefault boolForKey:@"isLogin"]) {
            return;
        }
        
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 清空所有的用户数据
            [LXUtil cleanUserInfo];
            [self.userName setText:@"未登录"];
            self.userImage.image = nil;
        }];
        
        UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"退出登陆" message:@"确定要退出登陆吗" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:cancle];
        [alert addAction:confirm];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
