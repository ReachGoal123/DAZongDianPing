//
//  WebViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-1.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    NSLog(@"~~~~~~~~~~~~~~%@",url);
    [self.view addSubview:self.webView];
    [self.webView loadRequest:re];
[self.webView.scrollView setContentInset:UIEdgeInsetsMake(-44, 0, 0, 0)];
    
    
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
