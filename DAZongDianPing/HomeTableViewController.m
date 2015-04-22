//
//  HomeTableViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//
#define TOPIC_COLOR_ORANGE [UIColor colorWithRed:247.0/255 green:135.0/255 blue:74.0/255 alpha:1.0]
#import "BusinessTableViewController.h"
#import "HomeTableViewController.h"
#import "WebUtils.h"
#import "BusinessTableViewCell.h"
@interface HomeTableViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *HeaderView;
@property (weak, nonatomic) IBOutlet UILabel *Headerlabel;
@property(strong,nonatomic)NSMutableArray * businesses;
@property(nonatomic,strong)NSMutableDictionary *params;
@property(nonatomic,assign)int currentPage;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.params = [NSMutableDictionary dictionary];
    
    
    
    [self initHeaderView];
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickedCategory:) name:@"clickedCategory" object:nil];
    
    
}

-(void)clickedCategory:(NSNotification*)notif{
    
 NSString *category = [notif.userInfo objectForKey:@"category"];
    [self performSegueWithIdentifier:@"businessvc" sender:category];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 1;
    [self.params setObject:@(self.currentPage) forKey:@"page"];
    [self.params setObject:@(20) forKey:@"limit"];
    [self initUI];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *cityName= [ud objectForKey:@"cityName"];
    if (!cityName) {
        cityName = @"北京";
        [ud setObject:cityName forKey:@"cityName"];
        [ud synchronize];
    }
    self.Headerlabel.text = cityName;
    
    
    
    
    [WebUtils requestBusinessAndCallback:^(id obj) {
        self.businesses = obj;
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
//        });
    }];

 self.tabBarController.tabBar.hidden = NO;
}

-(void)initUI{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    [self.navigationController.navigationBar addSubview:statusBarView];
    statusBarView.backgroundColor = TOPIC_COLOR_ORANGE;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = TOPIC_COLOR_ORANGE;
//    self.Headerlabel.text = @"北京";
}








-(void)initHeaderView{
    self.HeaderView =(UIScrollView*)self.tableView.tableHeaderView;
    self.HeaderView.frame = CGRectMake(0, 0, 920, 200);
    self.HeaderView.userInteractionEnabled = YES;
    self.HeaderView.showsHorizontalScrollIndicator = YES;
    self.HeaderView.showsVerticalScrollIndicator = NO;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.businesses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BusinessTableViewCell";
   BusinessTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"BusinessTableViewCell" owner:self options:nil]lastObject];
    }
    BussinessInfo *b = self.businesses[indexPath.row];
    cell.business = b;
    
    
    if (self.businesses.count-1==indexPath.row) {
        
        [self.params setObject:@(++self.currentPage) forKey:@"page"];
        [WebUtils requestBusinessWithParams:self.params AndCallback:^(id obj) {
            [self.businesses addObjectsFromArray:obj];
            [self.tableView reloadData];
        }];
    
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * str = @"猜你喜欢";
    
    return str;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BussinessInfo *bi = self.businesses[indexPath.row];
    
    WebViewController *webView = [[WebViewController alloc] init];
   webView.urlString = bi.business_url;
    
   webView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webView animated:YES];
    webView.hidesBottomBarWhenPushed = NO;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"businessvc"]) {
   BusinessTableViewController *vc = segue.destinationViewController;
    vc.category = sender;
  }
}

@end
