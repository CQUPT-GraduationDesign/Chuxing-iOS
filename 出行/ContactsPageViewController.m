//
//  ContactsPageViewController.m
//  出行
//
//  Created by 李鑫 on 16/3/18.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "ContactsPageViewController.h"

@interface ContactsPageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ContactsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initTextFields];
    
    
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


#pragma mark - private methods
/**
 *  初始化输入框的样式
 */
- (void)initTextFields {
    
    UIImage *userNameImage = [UIImage imageNamed:@"iconfont-user"];
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    userImageView.image = userNameImage;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.userNameTextField.frame.size.height, self.userNameTextField.frame.size.height)];
    [self.userNameTextField.leftView addSubview:userImageView];
    
    
    UIImage *passwordImage = [UIImage imageNamed:@"iconfont-password"];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    passwordImageView.image = passwordImage;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.passwordTextField.frame.size.height, self.passwordTextField.frame.size.height)];
    [self.passwordTextField.leftView addSubview:passwordImageView];
}


@end
