//
//  RegisterViewController.m
//  出行
//
//  Created by 李鑫 on 16/3/23.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>


@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@property (nonatomic, strong, readwrite) RegisterViewModel *viewModel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    if (self.viewModel == nil) {
        self.viewModel = [[RegisterViewModel alloc] init];
        [self.viewModel initialize];
    }
    
    [self bindViewModel];
    
    
    [self initTextFields];
    
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    
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

- (void)bindViewModel {
    
    @weakify(self)
    RAC(self.viewModel, username) = [self.usernameTextField rac_textSignal];
    RAC(self.viewModel, password) = [self.passwordTextField rac_textSignal];
    RAC(self.registerBtn, enabled) = self.viewModel.validRegisterSignal;
    [self.viewModel.registerCommand.executing subscribeNext:^(NSNumber *x) {
        self.registerBtn.enabled = !x.boolValue;
    }];
    
    
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)

        [[self.viewModel.registerCommand  execute:nil] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
//         subscribeCompleted:^{
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
    }];
    
}
- (void)initTextFields {
    
    UIImage *userNameImage = [UIImage imageNamed:@"iconfont-user"];
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    userImageView.image = userNameImage;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.usernameTextField.frame.size.height, self.usernameTextField.frame.size.height)];
    [self.usernameTextField.leftView addSubview:userImageView];
    
    
    UIImage *passwordImage = [UIImage imageNamed:@"iconfont-password"];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    passwordImageView.image = passwordImage;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.passwordTextField.frame.size.height, self.passwordTextField.frame.size.height)];
    [self.passwordTextField.leftView addSubview:passwordImageView];
}


@end
