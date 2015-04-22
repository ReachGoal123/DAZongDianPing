//
//  movieTableViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "movieTableViewController.h"
#import "MovieTView.h"
#import "Moive.h"
#import "WebUtils.h"
@interface movieTableViewController ()
@property (nonatomic)int sourceType;
@property (nonatomic, strong)NSMutableArray *movies;
@property (weak, nonatomic) IBOutlet UILabel *Mnamelb;
@property (weak, nonatomic) IBOutlet UILabel *Mlb;
@property (weak, nonatomic) IBOutlet UIImageView *myIM;


@end

@implementation movieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    MovieTView *headerView = (MovieTView *)self.tableView.tableHeaderView;
    headerView.movie = self.movie;
    self.movies = [NSMutableArray array];
    [WebUtils requestMoivesWithMoiveName:self.movieName AndCallback:^(id obj) {
        
        self.movies = obj;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];

    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sourceTypeChange:) name:@"sourceChange" object:nil];
}

- (void)sourceTypeChange:(NSNotification *)noti{
    
    self.sourceType  = [[noti.userInfo objectForKey:@"sourceType"] intValue];
    [self.tableView reloadData];
    
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;

//    if (self.sourceType==0) {
//        return self.movie.actors.count;
//    }else{
//        return self.movie.sources.count;
//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    if (self.sourceType==0) {
//        NSString *actorName = [self.movie.actors[indexPath.row]objectForKey:@"name"];
//        cell.textLabel.text = actorName;
//    }else{
//        NSString *sourceName = [self.movie.sources[indexPath.row]objectForKey:@"source"];
//        cell.textLabel.text = sourceName;
//    }
    self.hidesBottomBarWhenPushed = YES;
    cell.textLabel.text = @"点击进入";
    
    return cell;
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
