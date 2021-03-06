//
//  LXNavigationProtocol.h
//  出行
//
//  Created by 李鑫 on 16/4/3.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXViewModel.h"

@protocol LXNavigationProtocol <NSObject>


- (void)pushViewModel:(LXViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(LXViewModel *)viewModel animated:(BOOL)animated completion:(void (^)())completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^)())completion;

- (void)resetRootViewModel:(LXViewModel *)viewModel;

@end
