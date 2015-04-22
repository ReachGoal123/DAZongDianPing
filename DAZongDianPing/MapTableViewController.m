//
//  MapTableViewController.m
//  DAZongDianPing
//
//  Created by wanglin on 15-4-3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "MapTableViewController.h"
#import "WebUtils.h"
#import "BussinessInfo.h"
#import "MyAnnotation.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface MapTableViewController ()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *myMapV;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UILabel *EndLB;
@property (weak, nonatomic) IBOutlet UILabel *StartLB;
@property (weak, nonatomic) IBOutlet UISlider *mySld;
@property (weak, nonatomic) IBOutlet UIStepper *myStp;
@property (weak, nonatomic) IBOutlet UIButton *Btn;
//@property (nonatomic, weak)AppDelegate *app;
@property (nonatomic, strong)AVAudioPlayer *player;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSMutableArray *musicPaths;
@property (nonatomic)int currentIndex;
@end

@implementation MapTableViewController
-(void)creatMap{
    
    self.params = [NSMutableDictionary dictionary];
    
    self.myMapV =(MKMapView*)self.tableView.tableHeaderView;
    self.myMapV.frame = CGRectMake(0, 0, 320, 200);
    
    
    CLLocationCoordinate2D coord;
    coord.longitude =113.97557437419891 ;
    coord.latitude =22.542515420743065;
    [self.params setObject:@(coord.longitude) forKey:@"longitude"];
    [self.params setObject:@(coord.latitude) forKey:@"latitude"];
    [self.params setObject:@"5000" forKey:@"radius"];
    [WebUtils requestBusinessWithParams:self.params AndCallback:^(id obj) {
        [self addAnnotationsByArr:obj];
        
        
    }];
    
    
    [self.myMapV setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1, 0.1)) animated:YES];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMap];
    [self initUI];
    
    
    
    
    
    
}
-(void)initUI{
    self.myView = self.tableView.tableFooterView;
    
    self.myView.frame = CGRectMake(0, 0, 320, 100);
    [self.Btn addTarget:self action:@selector(clickon:) forControlEvents:UIControlEventTouchUpInside];
    [self.mySld addTarget:self action:@selector(ValueChange:) forControlEvents:UIControlEventSystemReserved];
    [self.myStp addTarget:self action:@selector(VolumeChange:) forControlEvents:UIControlEventSystemReserved];
//     self.app = [UIApplication sharedApplication].delegate;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(upMUI) userInfo:nil repeats:YES];
    
    self.musicPaths = [NSMutableArray array];
    NSString *path = @"/Users/tarena04/Desktop/music";
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *fileName in fileNames) {
        if ([fileName hasSuffix:@"mp3"]) {
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            [self.musicPaths addObject:filePath];
        }
        
    }
    [self creatMusic];
    
}

    
    
    


-(void)creatMusic{
    
   
    
   
    if (self.currentIndex==-1) {
        self.currentIndex = (int)self.musicPaths.count-1;
    }
    
    if (self.currentIndex==self.musicPaths.count) {
        self.currentIndex = 0;
    }
    NSString *path =self.musicPaths[self.currentIndex];
 self.player =[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
   self.player.delegate = self;
//     self.title = [[[path lastPathComponent]componentsSeparatedByString:@"."]firstObject];
    
    [self.player play];
    
    self.EndLB.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.player.duration/60,(int)self.player.duration%60];
    
    self.mySld.maximumValue = self.player.duration;
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
//    [ud synchronize];
//    self.myStp.value = [ud floatForKey:@"volume"];
      self.player.volume=self.myStp.value ;
   
    
    
}
-(void)clickon:(UIButton *)sender{
    if (self.player.isPlaying) {
        [self.player pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        [self.player play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }

}

-(void)upMUI{
    
    self.mySld.value = self.player.currentTime;
    self.StartLB.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.player.currentTime/60,(int)self.player.currentTime%60];
    
    
    
    
    
    
}
    
-(void)viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
}
    
-(void)ValueChange:(UISlider *)sender{
    sender.userInteractionEnabled = YES;
    self.player.currentTime = sender.value;
    
}
    
-(void)VolumeChange:(UIStepper *)sender{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setFloat:sender.value forKey:@"volume"];
     sender.userInteractionEnabled = YES;
    self.player.volume = sender.value;
//    [ud synchronize];
    
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
     self.currentIndex++;
    
    [self creatMusic];
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
      NSLog(@"位置发生改变了");
    CLLocationCoordinate2D coord = mapView.centerCoordinate;
    //需要发出请求 并且把当前位置的坐标作为参数
    [self.params setObject:@(coord.longitude) forKey:@"longitude"];
    [self.params setObject:@(coord.latitude) forKey:@"latitude"];
    [WebUtils requestBusinessWithParams:self.params AndCallback:^(id obj) {
        
        [self addAnnotationsByArr:obj];
        
    
    }];
    
    
   
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addAnnotationsByArr:(NSArray *)arr{
    
    
    for (BussinessInfo *bi in arr) {
        MyAnnotation *ann = [[MyAnnotation alloc]init];
        CLLocationCoordinate2D coord;
        coord.longitude = bi.longitude;
        coord.latitude = bi.latitude;
        
        ann.coordinate = coord;
        ann.title = bi.name;
        
        [self.myMapV addAnnotation:ann];
        
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.musicPaths.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *musicPath = self.musicPaths[indexPath.row];
    cell.textLabel.text = [[[musicPath lastPathComponent]componentsSeparatedByString:@"."]firstObject];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *musicPath = self.musicPaths[indexPath.row];
    self.currentIndex = indexPath.row;
    
    [self creatMusic];
    
    
}
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
