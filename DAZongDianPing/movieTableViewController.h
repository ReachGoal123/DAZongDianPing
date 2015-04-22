//
//  movieTableViewController.h
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Moive.h"
@interface movieTableViewController : UITableViewController
@property (nonatomic, strong)Moive *movie;
@property (nonatomic, copy)NSString *movieName;
@end
