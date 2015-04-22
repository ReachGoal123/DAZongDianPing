//
//  CitysTableViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-2.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "CitysTableViewController.h"
#import "pinyin.h"
@interface CitysTableViewController ()<UISearchBarDelegate,UISearchResultsUpdating>
@property(nonatomic,strong)NSMutableDictionary *cityDic;
@property(nonatomic,strong)NSArray *allKeys;
@property (nonatomic, strong)NSMutableArray *searchResults;
@property (nonatomic, strong)UISearchController *searchController;
@property(nonatomic, strong)UITableViewController *searchTVC;
@end

@implementation CitysTableViewController
-(void)initData{
    
    self.cityDic = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"citys" ofType:@"plist"];
    
    //NSLog(@"%@",path);
    NSArray *citys = [NSArray arrayWithContentsOfFile:path];
    
    for (NSString *cityName in citys) {
        char firstLetter = pinyinFirstLetter([cityName characterAtIndex:0]);
        NSString *key = [NSString stringWithFormat:@"%c",firstLetter];
        
        NSMutableArray *newCitys = [self.cityDic objectForKey:key];
        if (!newCitys) {
            newCitys = [NSMutableArray array];
            [self.cityDic setObject:newCitys forKey:key];
        }
        [newCitys addObject:cityName];
    }
    self.allKeys = [self.cityDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
  
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.title = @"选择城市";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backItem;
    self.searchResults = [NSMutableArray array];
    UIBarButtonItem *searchBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(SearchAction)];
    
    self.navigationItem.rightBarButtonItem = searchBar;
}
-(void)SearchAction{
    
    if (!_searchTVC) {
        _searchTVC = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    }
    self.searchTVC.tableView.dataSource = self;
    self.searchTVC.tableView.delegate = self;
    //创建搜索控制器
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchTVC];
    //当搜索框中的内容发生变化时，由谁来处理
    self.searchController.searchResultsUpdater = self;
    //提示信息
    self.searchController.searchBar.placeholder = @"城市名称";
    self.searchController.searchBar.prompt = @"请输入要查询的城市";
    //展示搜索控制器
    [self presentViewController:self.searchController animated:YES completion:nil];
    
    
}

-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.allKeys[section];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([tableView isEqual:self.searchTVC.tableView]) {
        return 1;
    }else{
    
    return  self.cityDic.allKeys.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     if ([tableView isEqual:self.searchTVC.tableView]) {
         return self.searchResults.count;
     }else{
    NSString *key = self.allKeys[section];
    
    NSArray *citys = [self.cityDic objectForKey:key];

    return citys.count;
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellName = @"UITableViewCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    
  if ([tableView isEqual:self.searchTVC.tableView]) {
      
      cell.textLabel.text = self.searchResults[indexPath.row];
      
  }else{
    NSString *key = self.allKeys[indexPath.section];
    NSArray *citys = [self.cityDic objectForKey:key];
    
    NSString *cityName = citys[indexPath.row];
    cell.textLabel.text = cityName;
  }
    return cell;
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.allKeys;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cityName = nil;
    if ([tableView isEqual:self.searchTVC.tableView]) {
        cityName = self.searchResults[indexPath.row];

    }else{

    NSString *key = self.allKeys[indexPath.section];
    NSArray *citys = [self.cityDic objectForKey:key];
    
    cityName = citys[indexPath.row];

    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:cityName forKey:@"cityName"];
    [ud synchronize];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cityChange" object:nil userInfo:@{@"cityName": cityName}];
    
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


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


#pragma mark UISearchDelegate
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //1. 获取输入的要搜索的数据
    NSString *conditionStr = searchController.searchBar.text;
    
    //2. 创建谓词, 准备进行判断
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", conditionStr];
    //每次查询前把之前搜索的都删除掉
    [self.searchResults removeAllObjects];
    
    for (NSString *key in self.allKeys) {
        NSArray *citys = [self.cityDic objectForKey:key];
        //        把每个城市数组中符合条件的得到
        NSArray *results = [citys filteredArrayUsingPredicate:predicate];
        [self.searchResults addObjectsFromArray:results];
    }
    //4. 刷新
    [self.searchTVC.tableView reloadData];
    
    
    
    
    
}

@end
