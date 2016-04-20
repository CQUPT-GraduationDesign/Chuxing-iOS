//
//  MapViewController.m
//  出行
//
//  Created by 李鑫 on 16/4/20.
//  Copyright © 2016年 Kee. All rights reserved.
//

#import "MapViewController.h"
#import <Masonry/Masonry.h>
#import "LXUtil.h"

@interface MapViewController () <UIWebViewDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@(600));
    }];
    
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    [(UIScrollView *)[[webView subviews] objectAtIndex:0]    setBounces:NO];
    
    NSString *path = [LXUtil getWebviewStringWithStartCity:_start middle:_middle end:_end];
    

    [webView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString: path]]];
    
}

- (BOOL)validateUrl:(NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGRect frame = webView.frame;
    
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    
    frame.size = fittingSize;
    
    webView.frame = frame;
    
}

@end
