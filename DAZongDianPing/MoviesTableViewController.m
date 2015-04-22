//
//  MoviesTableViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "movieTableViewController.h"
#import "MovieTableViewCell.h"
#import "Moive.h"
#import "WebUtils.h"
@interface MoviesTableViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myText;
@property(nonatomic,strong) NSMutableArray *images;

@property (nonatomic, strong)UISearchController *searchController;
@property(nonatomic, strong)UITableViewController *searchTVC;
@end

@implementation MoviesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [NSMutableArray array];
    NSString *path = @"/Users/tarena04/Desktop/美女";
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *finames = [manager contentsOfDirectoryAtPath:path error:nil];
   for (NSString *filename in finames) {
        if ([filename hasSuffix:@"jpg"]) {
            NSString *fpath = [path stringByAppendingPathComponent:filename];
           [self.images addObject:fpath];
           
       }
   }
        UIImageView *IM =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
       
        IM.image = [UIImage imageNamed:@"引导页－2.jpg"];
        [self.tableView setBackgroundView:IM];
        
      
     
     
        
  
}
//    UIBarButtonItem *searchBar = [[UIBarButtonItem  引导页－2.jpg alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(SearchAction)];
//    
//    self.navigationItem.rightBarButtonItem = searchBar;
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.images.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *fpath = self.images[indexPath.row];
    cell.textLabel.text =[[[fpath lastPathComponent]componentsSeparatedByString:@"."]firstObject];
    cell.backgroundColor = [UIColor clearColor];
    
//    cell.imageView.image = [[UIImage imageNamed:[[[fpath lastPathComponent]componentsSeparatedByString:@"/"] lastObject]];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NSString *fpath = self.images[indexPath.row];
    UIViewController *vc = [[UIViewController alloc]init];
    UIImageView *IM =[[UIImageView alloc]initWithFrame:vc.view.bounds];
    IM.image = [UIImage imageWithContentsOfFile:fpath];
    [IM setContentMode:UIViewContentModeScaleAspectFit];
    [vc.view addSubview:IM];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}

//- (IBAction)Seach:(id)sender {
//    self.movieName = self.myText.text;
//}
//
//    if (!_searchTVC) {
//        _searchTVC = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
//    }
//    self.searchTVC.tableView.dataSource = self;
//    self.searchTVC.tableView.delegate = self;
//    创建搜索控制器
//    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self];
   
////    提示信息 
//    self.searchController.searchBar.placeholder = @"电影/明星名称";
//    
//     }

//
//
//
//    //展示搜索控制器
//[self presentViewController:self.searchController animated:YES completion:nil];
//    

    
    

//-(void)viewDidAppear:(BOOL)animated{
//   
//    
//}
//-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//    
//    self.movieName = searchController.searchBar.text;
////    [WebUtils requestMoivesWithMoiveName:self.movieName AndCallback:^(id obj) {
////        
////        self.movies = obj;
////        //        dispatch_async(dispatch_get_main_queue(), ^{
////        [self.searchTVC.tableView reloadData];
////        //        });
////        
////    }];

    
    
    
    
    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//   
//        
////    cell.movie = self.movies[indexPath.row];
// 
//    
//    
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    Moive *m = self.movies[indexPath.row];
//    [self performSegueWithIdentifier:@"movievc" sender:m];
    
//}

/* 小时代
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"starvc"]) {
        movieTableViewController *vc = segue.destinationViewController;
        vc.movieName = self.myText.text;
//        vc.movie = sender;
    }
}


@end
