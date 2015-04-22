//
//  FiestViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-2.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "FiestViewController.h"

@interface FiestViewController ()

@end

@implementation FiestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"category" ofType:@"plist"];
    self.dataDict = [NSMutableDictionary dictionaryWithContentsOfFile:path ];
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
