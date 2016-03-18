//
//  ContactsPageViewController.m
//  出行
//
//  Created by 李鑫 on 16/3/18.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "ContactsPageViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSInteger, LoginShowType) {
    LoginShowTypeNone,
    LoginShowTypeUser,
    LoginShowTypePassword
};

const static CGFloat offsetHand = 60;

@interface ContactsPageViewController ()<UITextFieldDelegate> {
    
    LoginShowType showType;

}

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIImageView *rightHandShow;
@property (weak, nonatomic) IBOutlet UIImageView *leftHandShow;
@property (weak, nonatomic) IBOutlet UIImageView *rightHandHide;
@property (weak, nonatomic) IBOutlet UIImageView *leftHandHide;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHandShowLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHandShowTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHandShowTriling;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHandShowTop;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHandHideTriling;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHandHideHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHandHideWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHandHideLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHandHideHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHandHideWidth;

@end

@implementation ContactsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initTextFields];
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    showType = LoginShowTypeUser;
    
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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:_userNameTextField]) {
        
        if (showType == LoginShowTypeUser) {
            //showType = LoginShowTypeUser;
            return;
        }
        showType = LoginShowTypeUser;
        
        [UIView animateWithDuration:0.5 animations:^{
            _leftHandShowTriling.constant = _leftHandShowTriling.constant + 50;
            _leftHandShowTop.constant = _leftHandShowTop.constant + 50;
            
            _rightHandShowLeading.constant = _rightHandShowLeading.constant + 50;
            _rightHandShowTop.constant = _rightHandShowTop.constant + 50;
            
            
            _rightHandHideTriling.constant = _rightHandHideTriling.constant + 70;
            _rightHandHideWidth.constant = 40;
            _rightHandHideHeight.constant = 40;
            
            _leftHandHideLeading.constant = _leftHandHideLeading.constant - 70;
            _leftHandHideWidth.constant = 40;
            _leftHandHideHeight.constant = 40;
            
            
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    } else if ([textField isEqual:_passwordTextField]) {
        
        if (showType == LoginShowTypePassword) {
            //showType = LoginShowTypePassword;
            return;
        }
        showType = LoginShowTypePassword;
        
        [UIView animateWithDuration:0.5 animations:^{
            // 移动档眼睛的手
            _leftHandShowTriling.constant = _leftHandShowTriling.constant - 50;
            _leftHandShowTop.constant = _leftHandShowTop.constant - 50;
            
            _rightHandShowLeading.constant = _rightHandShowLeading.constant - 50;
            _rightHandShowTop.constant = _rightHandShowTop.constant - 50;
            
            // 移动放在旁边的手
            _rightHandHideTriling.constant = _rightHandHideTriling.constant - 70;
            _rightHandHideWidth.constant = 0;
            _rightHandHideHeight.constant = 0;
            
            _leftHandHideLeading.constant = _leftHandHideLeading.constant + 70;
            _leftHandHideWidth.constant = 0;
            _leftHandHideHeight.constant = 0;
            
            
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
}


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
