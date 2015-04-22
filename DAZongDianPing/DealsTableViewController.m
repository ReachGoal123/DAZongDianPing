//
//  DealsTableViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "DealsTableViewController.h"
#import "WebUtils.h"
#import "Deal.h"
#import "DealTableViewCell.h"
#import "MHTabBarController.h"
#import "FiestViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "WebViewController.h"

@interface DealsTableViewController ()<MHTabBarControllerDelegate>
@property(strong,nonatomic)NSMutableArray * deals;
@property (nonatomic, strong)MHTabBarController *tbc;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic)int currentPage;



@end

@implementation DealsTableViewController

-(void)subViewController:(UIViewController *)subViewController SelectedCell:(NSString *)selectedText{
    if ([subViewController.title isEqualToString:@"全部分类"]) {
        [self.params setObject:selectedText forKey:@"category"];

    }else if([subViewController.title isEqualToString:@"全部地区"]){
        [self.params setObject:selectedText forKey:@"region"];
    
    }else{//排序
        int sortType = 1;
        if ([selectedText isEqualToString:@"价格低优先"]) {
            sortType = 2;
        }else if ([selectedText isEqualToString:@"价格高优先"]) {
            sortType = 3;
        }else if ([selectedText isEqualToString:@"购买人数多优先"]) {
            sortType = 4;
        }
        [self.params setObject:@(sortType) forKey:@"sort"];
    
    }
    [WebUtils requestDealsWithParams:self.params AndCallback:^(id obj) {
        self.deals = obj;
        [self.tableView reloadData];
    }];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.params = [NSMutableDictionary dictionary];
    self.currentPage = 1;
    [self.params setObject:@(self.currentPage) forKey:@"page"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDeals];
    
    [self createTabBar];
}

-(void)createTabBar{
    
    if (self.tbc) {
        return;
    }
    self.tbc = [[MHTabBarController alloc]init];
    self.tbc.delegate = self;
    FiestViewController *first = [[FiestViewController alloc]init];
    first.title = @"全部分类";
    SecondViewController *second = [[SecondViewController alloc]init];
    second.title = @"全部地区";
    ThirdViewController *third = [[ThirdViewController alloc]init];
    third.title = @"智能排序";
    
    self.tbc.viewControllers = @[first,second,third];
    //    因为当前是tableViewController 需要添加到    俯视图navi里面
    
    self.tableView.tableHeaderView = self.tbc.view;
    //让内容显示在bar下面
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    
}

-(void)getDeals{
    
    [WebUtils requestDealsWithParams:@{} AndCallback:^(id obj) {
        self.deals = obj;
        [self.tableView reloadData];
    }];
}




- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

     return self.deals.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Dealcell";
    DealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DealTableViewCell" owner:self options:nil]lastObject];
    }
    cell.deal = self.deals[indexPath.row];
   //判断显示的是最后一行
    if (indexPath.row == self.deals.count-1) {
        [self.params setObject:@(++self.currentPage) forKey:@"page"];
        [WebUtils requestDealsWithParams:self.params AndCallback:^(id obj) {
            [self.deals addObjectsFromArray:obj];
            [self.tableView reloadData];
        }];
    }
    
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController *vc = [[WebViewController alloc]init];
    
    vc.urlString = ((Deal*)[self.deals objectAtIndex:indexPath.row]).deal_h5_url;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
    
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
