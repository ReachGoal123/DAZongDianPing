//
//  WebViewController.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-1.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (copy,nonatomic) NSString *urlString;
@property (strong,nonatomic) UIWebView *webView;
@end
