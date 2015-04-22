//
//  CitysTableViewController.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-2.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewController.h"
@interface CitysTableViewController : UITableViewController
@property (nonatomic, weak)HomeTableViewController *delegate;
@end
