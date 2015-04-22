//
//  BusinessTableViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-1.
//  Copyright (c) 2015年 tarena. All rights reserved.
//
#import "WebViewController.h"
#import "BusinessTableViewController.h"
#import "BussinessInfo.h"
#import "BusinessTableViewCell.h"
#import "WebUtils.h"

@interface BusinessTableViewController ()
@property(nonatomic,strong)NSArray *busics;
@end

@implementation BusinessTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getBusinesses];
    
}

-(void)getBusinesses{
    
    
    [WebUtils requestBusinessWithParams:@{@"category":self.category} AndCallback:^(id obj) {
        self.busics = obj;
        [self.tableView reloadData];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.busics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cells = @"BusinessTableViewCell";
    BusinessTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cells];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessTableViewCell" owner:self options:nil]lastObject];
    }
    
    BussinessInfo * business = self.busics[indexPath.row];
    cell.business = business;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BussinessInfo * business = self.busics[indexPath.row];
    WebViewController *wvc = [[WebViewController alloc]init];
    wvc.urlString = business.business_url;
    //通过navigationcontroller跳转页面时 如果当前实在tabbarController里面 下一个页面不显示下面的bar
    wvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:wvc animated:YES];
    
    
    
}




@end
